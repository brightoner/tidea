var gs_SSO_PROTOCOL= "https://";
var gs_SSO_DOMAIN  = "sso.kisti.re.kr/ks20/";
//var gs_SSO_PROTOCOL= "http://";
//var gs_SSO_DOMAIN  = "sso.kisti.dev:8089/ks20/";
var gs_SSO_CALLURL = "sso_process.do";
var gs_SSO_BRIDGE = "sso_bridge.do"

var gs_SSOURL = gs_SSO_PROTOCOL + gs_SSO_DOMAIN + gs_SSO_CALLURL;
var gs_POPSSOURL = gs_SSO_PROTOCOL + gs_SSO_DOMAIN + gs_SSO_BRIDGE;

var gs_returnURL= "";
//http://sso.kisti.re.kr/ks20/sso_process.do

// 00. 브라우져 체크 및 환경변수 셋팅
var isMinNS4 = (navigator.appName.indexOf("Netscape") >= 0 && parseFloat(navigator.appVersion) >= 4) ? 1 : 0;
var isMinIE4 = (document.all) ? 1 : 0;
var isMinIE5 = (isMinIE4 && navigator.appVersion.indexOf("5.")) >= 0 ? 1 : 0;
var _small_optionstr = 'width=775,height=700,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbar=yes,scrollbars=yes,resizable=yes,copyhistory=no';
var _large_optionstr = 'width=1024,height=700,left=0,top=0,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbar=yes,scrollbars=yes,resizable=yes,copyhistory=no';


Number.prototype.to2 = function() { return (this > 9 ? "" : "0")+this; };
Date.MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
Date.DAYS   = ["Sun", "Mon", "Tue", "Wed", "Tur", "Fri", "Sat"];
Date.prototype.getDateString = function(dateFormat) {
  var result = "";
  
  dateFormat = dateFormat == 8 && "YYYY.MM.DD" ||
               dateFormat == 6 && "hh:mm:ss" ||
               dateFormat ||
               "YYYY.MM.DD hh:mm:ss";
  for (var i = 0; i < dateFormat.length; i++) {
    result += dateFormat.indexOf("YYYY", i) == i ? (i+=3, this.getFullYear()                     ) :
              dateFormat.indexOf("YY",   i) == i ? (i+=1, String(this.getFullYear()).substring(2)) :
              dateFormat.indexOf("MMM",  i) == i ? (i+=2, Date.MONTHS[this.getMonth()]           ) :
              dateFormat.indexOf("MM",   i) == i ? (i+=1, (this.getMonth()+1).to2()              ) :
              dateFormat.indexOf("M",    i) == i ? (      this.getMonth()+1                      ) :
              dateFormat.indexOf("DDD",  i) == i ? (i+=2, Date.DAYS[this.getDay()]               ) :
              dateFormat.indexOf("DD",   i) == i ? (i+=1, this.getDate().to2()                   ) :
              dateFormat.indexOf("D"   , i) == i ? (      this.getDate()                         ) :
              dateFormat.indexOf("hh",   i) == i ? (i+=1, this.getHours().to2()                  ) :
              dateFormat.indexOf("h",    i) == i ? (      this.getHours()                        ) :
              dateFormat.indexOf("mm",   i) == i ? (i+=1, this.getMinutes().to2()                ) :
              dateFormat.indexOf("m",    i) == i ? (      this.getMinutes()                      ) :
              dateFormat.indexOf("ss",   i) == i ? (i+=1, this.getSeconds().to2()                ) :
              dateFormat.indexOf("s",    i) == i ? (      this.getSeconds()                      ) :
                                                   (dateFormat.charAt(i)                         ) ;
  }
  return result;
};




//-----------------------------------------------------------------------------
// 00. 통합 인증 시스템 접근 공통 함수  
//-----------------------------------------------------------------------------
function TT_UserWin(urlcode, sitecode, rturl, etcurl) { 
  if ( urlcode < 1 || urlcode > 7 ) { alert("URL 코드가 입력되지 않은 잘못된 접근입니다\n관리자에게 문의 하시면 신속히 처리 될 것입니다"); return;}
  if ( sitecode == "" ) { alert("사이트 코드가 입력되지 않은 잘못된 접근입니다\n관리자에게 문의 하시면 신속히 처리 될 것입니다");  return;}
  urlstr = gs_POPSSOURL + "?requestType=" + urlcode;

  gourl = urlstr + "&server_num=" + sitecode + "&returnURL=" + escape(rturl) + etcurl
  if ( urlcode > 0 && urlcode < 7 ) { optionstr = _small_optionstr ; 
  } else { optionstr = _large_optionstr ; }
  NewWindow=window.open(gourl,'TT_user',optionstr) ;
} 

//-----------------------------------------------------------------------------
// 01. 로그인 Check
//-----------------------------------------------------------------------------
function TT_UserLoginCheck(as_servernum){
	if(as_servernum == null || as_servernum == "" ){alert("패밀리사이트 코드를 넣어주십시오."); return false; }
	var sso_thefrm = gf_makeLoginForm();
	if(sso_thefrm != null){
		sso_thefrm.requestType.value ="0";
		sso_thefrm.returnURL.value = "http://" + location.host + location.pathname + "?ischeck=ok";
		sso_thefrm.server_num.value = as_servernum;		
		sso_thefrm.action = gs_SSOURL;
		sso_thefrm.submit();
	}		
}


//-----------------------------------------------------------------------------
// 02. 폼 로그인 처리 함수
//-----------------------------------------------------------------------------
function TT_UserLogin(as_formname) {
  /* 폼 테그 체크 */
  var sso_thefrm = document.all(as_formname);
  if(sso_thefrm == null){alert("잘못된 [로그인 form이름]을 지정하셨습니다"); return false; }
  
  /* 폼 구성 항목 지정 */
  var sso_userid = sso_thefrm.userid ;
  var sso_passwd = sso_thefrm.password ;
  var sso_server_num = sso_thefrm.server_num ;
  var sso_returnURL = sso_thefrm.returnURL ;

  /* 로그인 폼 구성 유효성 검사 */
  if(sso_userid == null ){alert("[아이디 입력 항목] 잘못 지정된 접근입니다.\n\n관리자에게 문의 하시면 신속히 처리 될 것입니다"); return false; }
  if(sso_passwd == null ){alert("[비밀번호 입력 항목] 잘못 지정된 접근입니다.\n\n관리자에게 문의 하시면 신속히 처리 될 것입니다"); return false; }
  if(sso_server_num == null || sso_server_num.value.length != 4 ){alert("[서버번호 항목] 잘못 지정된 접근입니다.\n\n관리자에게 문의 하시면 신속히 처리 될 것입니다"); return false; }
  if(sso_returnURL == null || sso_returnURL.value == "" || sso_returnURL.value.substr(0,4).toLowerCase() != "http" ){alert("[returnURL]이 잘못 지정 및 입력되지 않았거나 \n 'http://www.aaa.org/xxx.jsp'로 시작되는 [FULL URL]이 아닌 잘못된 접근입니다\n\n관리자에게 문의 하시면 신속히 처리 될 것입니다"); return false; }
  
  if( sso_userid.value == "" ) { alert(" 이용자 ID를 입력해 주세요 "); sso_userid.focus(); return false; }
  if ( sso_passwd.value == "" ) { alert(" 비밀번호를 입력해 주세요 "); sso_passwd.focus(); return false; } 
  
  sso_thefrm.requestType.value = "1";
  
  if( sso_server_num.value == "SS00" ) {
 	  sso_thefrm.action = goserver_host + "login.do";	  
  }else{
	  //NewWindow= window.open('about:blank','KISTI_SSO_SERVICE',_ssmall_optionstr) ;
	  //gf_makeiFrame();	  
	  sso_thefrm.action = gs_SSOURL;
	 //sso_thefrm.target = 'ssoifrm' ;	  
  }
  alert(sso_thefrm.requestType.value);
  sso_thefrm.submit();    
}

//-----------------------------------------------------------------------------
// 03. 로그아웃 처리 함수
//-----------------------------------------------------------------------------
function TT_UserLogout(as_servernum, as_userid, as_returnURL){
	var sso_thefrm = gf_makeLoginForm();
	gf_makeiFrame();
	if(sso_thefrm != null){
		sso_thefrm.userid.value = as_userid;
		sso_thefrm.requestType.value ="6";
		sso_thefrm.server_num.value = as_servernum;		
		sso_thefrm.action = gs_SSOURL;
		sso_thefrm.target = "ssoifrm";
		sso_thefrm.submit();
	}	
	location.href=	as_returnURL;
}


//-----------------------------------------------------------------------------
// 04. 회원탈퇴
//-----------------------------------------------------------------------------
function TT_UserWithDraw(as_servernum, as_userid, as_returnurl){
	var sso_thefrm = gf_makeLoginForm();
	gf_makeiFrame();
	if(sso_thefrm != null){
		sso_thefrm.userid.value = as_userid;
		sso_thefrm.requestType.value ="5";
		sso_thefrm.returnURL.value = as_returnurl;
		sso_thefrm.server_num.value = as_servernum;		
		sso_thefrm.action = gs_SSOURL;
		sso_thefrm.target = "ssoifrm";
		sso_thefrm.submit();
	}
}

//-----------------------------------------------------------------------------
// 05. 회원정보 얻기
//-----------------------------------------------------------------------------
function TT_UserInfo(as_userid, as_returnurl, as_servernum){
	var sso_thefrm = gf_makeLoginForm();
	if(sso_thefrm != null){
		sso_thefrm.userid.value = as_userid;
		sso_thefrm.requestType.value ="7";
		sso_thefrm.returnURL.value = as_returnurl;
		sso_thefrm.server_num.value = as_servernum;		
		sso_thefrm.action = gs_SSOURL;
		sso_thefrm.submit();
	}
}

//-----------------------------------------------------------------------------
// 05. 회원가입 및 회원정보수정
//-----------------------------------------------------------------------------
function gf_ssoProcess(ao_frm, as_requestType, as_retrunURL, as_siteNum){
	var strxmldata = gf_makeSSoXml(ao_frm, as_requestType, as_retrunURL,as_siteNum);
	alert(strxmldata);
	//return;
	gf_makeiFrame();
	var ofrm = gf_makeSSoForm();
	if(ofrm != null) {	
		ofrm.xmldata.value = strxmldata;
		ofrm.server_num.value = as_siteNum;
		ofrm.requestType.value=as_requestType;
		ofrm.returnURL.value =gs_returnURL;
		ofrm.action = gs_SSOURL;
		ofrm.target = "ssoifrm";
		//alert(ofrm.action);
		ofrm.submit();
	}
}


//-----------------------------------------------------------------------------
// 06. FamilySite 레이어 보이기
//-----------------------------------------------------------------------------
function TT_FamilySite(Layer_FamilySite){
	Obj_Layer = getLayer(Layer_FamilySite)
	if(Obj_Layer){
		if ( isMinIE4 ) {
	 	 	if ( Obj_Layer.style.visibility == "hidden" )  {
	 	 		Obj_Layer.style.visibility = "visible";	 	
	 	 		
	 	 	}else  Obj_Layer.style.visibility = "hidden";
	 	}else{
	 	 	if ( Obj_Layer.visibility == "hide" )  {
	 	 		Obj_Layer.style.visibility = "show";	 	
	 	 		
	 	 	}else  Obj_Layer.visibility = "hide";	 	
		}
	}else{ alert("레이어 정의가 잘못 되었습니다.\n 관리자에게 문의 하시면 신속히 수정 처리 하겠습니다"); }
}

//-----------------------------------------------------------------------------
// Layer utilities.
//-----------------------------------------------------------------------------

// 레이어 객체 얻기
function getLayer(name) {
  if (isMinNS4) return findLayer(name, document);
  if (isMinIE4) return eval('document.all.' + name);
  return null;
}

// 넷스케이프에서 레이어 객체 찾기
function findLayer(name, doc) {
  var i, layer;
  for (i = 0; i < doc.layers.length; i++) {
    layer = doc.layers[i];
    if (layer.name == name) return layer;
    if (layer.document.layers.length > 0) {
      layer = findLayer(name, layer.document);
      if (layer != null) return layer;
    }
  }
  return null;
}



function gf_CreateDom(){
	var domObj;
	if (window.ActiveXObject)
	{
		domObj = new ActiveXObject("Microsoft.XMLDOM");
		
	} else {
		// code for Mozilla, Firefox, Opera..
		var parser = new DOMParser();
		domObj = parser.parseFromString(req.responseText, "text/xml");
	}
	return domObj;
}

function gf_makeSSoXml(ao_frm, as_reqeustType, as_returnUrl, as_siteCode){
	var frm = ao_frm;		
	var xmlDoc = gf_CreateDom();
	var PInode = xmlDoc.createProcessingInstruction("xml","version='1.0' encoding='utf-8'");
	var RootNode = xmlDoc.createElement("request");
	var Headernode = xmlDoc.createElement("header");
	var requestTypenode = xmlDoc.createElement("requestType");
	var requestDatenode = xmlDoc.createElement("requestDate");
	var siteCodenode = xmlDoc.createElement("siteCode");
	var returnURLnode = xmlDoc.createElement("returnURL");
	
	
	xmlDoc.appendChild(PInode);
	xmlDoc.appendChild(RootNode);
		
	
	var elName = "";
	var elValue = "";
	var argStr = new Array();
	var argCnt = 0;
	
	
	var sStr_userid 	= "";
	var sStr_username 	= "";
	var sStr_foreign_username 	= "";
	var sStr_userengname = "";
	var sStr_password 	= "";
	var sStr_companyid 	= "";
	var sStr_company 	= "";
	var sStr_branch 	= "";
	var sStr_addrtype 	= "";
	var sStr_phone 		= "";
	var sStr_fax 		= "";
	var sStr_zipcode 	= "";
	var sStr_addr_1 	= "";
	var sStr_addr_2		= "";
	var sStr_email 		= "";
	var sStr_hpno 		= "";
	var sStr_mailflag 	= "";
	var sStr_smsflag 	= "";
	var sStr_ssn_code 	= "";
	var sStr_userpart 	= "";
	var sStr_degree 	= "";
	var sStr_major 		= "";
	var sStr_subject 	= "";
	var sStr_job		= "";
	var sStr_post 		= "";
	var sStr_country 	= "";
	var sStr_birthday 	= "";
	var sStr_sex 		= "";
	
	var sTemp_Phone_0 = "";
	var sTemp_Phone_1 = "";
	var sTemp_Phone_2 = "";
	var sTemp_Phone_3 = "";
	var sTemp_Fax_0 = "";
	var sTemp_Fax_1 = "";
	var sTemp_Fax_2 = "";
	var sTemp_Fax_3 = "";
	var sTemp_HP_0 = "";
	var sTemp_HP_1 = "";
	var sTemp_HP_2 = "";
	var sTemp_HP_3 = "";	
	var sTemp_Email_1 = "";
	var sTemp_Email_2 = "";
	var sTemp_HP = "";
	var sTemp_Phone = "";
	var sTemp_Fax ="";
	var sTemp_Email = "";
	
	

	for( inx = 0; inx < frm.elements.length; inx++) {
		elName =  frm.elements[inx].name;
		elValue =  frm.elements[inx].value;
		
		if(frm.elements[inx].type.toLowerCase() == "radio" && frm.elements[inx].checked == true) {
			switch (elName.toLowerCase()){
				case "sex":
					sStr_sex = elValue;
					break;
				case "addrtype":
					sStr_addrtype = elValue;
					break;
				case "mailflag":
					sStr_mailflag = elValue;
					break;
				case "smsflag":
					sStr_smsflag = elValue;
					break;	
			}
		}
		
		switch (elName.toLowerCase()){
			
			case "country":
				sStr_country = elValue;
				break;
			case "phone_0":
				sTemp_Phone_0 = elValue;
				break;
			case "phone_1":
				sTemp_Phone_1 = elValue;
				break;
			case "phone_2":
				sTemp_Phone_2 = elValue;
				break;
			case "phone_3":
				sTemp_Phone_3 = elValue;
				break;
			case "phone":
				sTemp_Phone = elValue;
				break;	
			case "fax_0":
				sTemp_Fax_0 = elValue;
				break;
			case "fax_1":
				sTemp_Fax_1 = elValue;
				break;
			case "fax_2":
				sTemp_Fax_2 = elValue;
				break;
			case "fax_3":
				sTemp_Fax_3 = elValue;
				break;
			case "fax":
				sTemp_Fax = elValue;
				break;
			case "hpno_0":
				sTemp_HP_0 = elValue;
				break;
			case "hpno_1":
				sTemp_HP_1 = elValue;
				break;	
			case "hpno_2":
				sTemp_HP_2 = elValue;
				break;		
			case "hpno_3":
				sTemp_HP_3 = elValue;
				break;	
			case "hpno":
				sTemp_HP = elValue;
				break;
			case "email_dcode":
				break;
			case "job1":
				break;
			case "job2":
				break;
			case "job3":
				break;
			case "job":
				sStr_job = elValue;
				break;
			case "post":
				sStr_post = elValue;
				break;
			case "degree":
				sStr_degree = elValue;
				break;
			case "major1":
				break;
			case "major2":
				break;
			case "major":
				sStr_major = elValue;
				break;
			case "subject":
				sStr_subject = elValue;
				break;		
			case "userid":
				sStr_userid = elValue;
				break;
			case "username":
				sStr_username = elValue;
				break;
			case "userengname":
				sStr_userengname = elValue;
				break;
			case "foreign_username":
				sStr_foreign_username = elValue;
				break;
			case "comseq1":
				break;
			case "comseq2":
				break;
			case "comseq3":
				break;	
			case "birthday":
				sStr_birthday = elValue;
				break;
			case "zipcode":
				sStr_zipcode = elValue;
				break;
			case "addr_1":
				sStr_addr_1 = elValue;
				break;
			case "addr_2":
				sStr_addr_2 = elValue;
				break;
			case "email_1":
				sTemp_Email_1 = elValue;
				break;
			case "email_2":
				sTemp_Email_2 = elValue;
				break;	
			case "email" :
				sTemp_Email = elValue;
				break;
			case "company":
				sStr_company = elValue;
				break;	
			case "branch":
				sStr_branch = elValue;
				break;	
			case "userpart":
				sStr_userpart = elValue;
				break;
			case "ssn_code":
				sStr_ssn_code = elValue;
				break;
			case "companyid":
				sStr_companyid = elValue;
				break;
			case "password" :
				sStr_password = elValue;
				break;
			case "password2" :
				break;
			default :							
				argStr[argCnt] =  elName + "=" + elValue;
				argCnt ++;
				break;
		}
			
			
			
/*			
			if(frm.elements[inx].type.toLowerCase() == "radio"
				&& frm.elements[inx].checked == true) {
					switch (elName.toLowerCase()){
						case "sex":
							sStr_sex = elValue;
							break;
						case "addrtype":
							sStr_addrtype = elValue;
							break;
						case "mailflag":
							sStr_mailflag = elValue;
							break;
						case "smsflag":
							sStr_smsflag = elValue;
							break;
						default :
							argStr[argCnt] =  elName + "=" + elValue;
							argCnt ++;
							break;
					}
			}else if (frm.elements[inx].type.toLowerCase() == "select-one"){
				switch (elName.toLowerCase()){
						case "country":
							sStr_country = elValue;
							break;
						case "phone_0":
							sTemp_Phone_0 = elValue;
							break;
						case "phone_1":
							sTemp_Phone_1 = elValue;
							break;
						case "fax_0":
							sTemp_Fax_0 = elValue;
							break;
						case "fax_1":
							sTemp_Fax_1 = elValue;
							break;
						case "hpno_0":
							sTemp_HP_0 = elValue;
							break;
						case "hpno_1":
							sTemp_HP_1 = elValue;
							break;	
						case "email_dcode":
							break;
						case "job1":
							break;
						case "job2":
							break;
						case "job3":
							break;
						case "post":
							sStr_post = elValue;
							break;
						case "degree":
							sStr_degree = elValue;
							break;
						case "major1":
							break;
						case "major2":
							break;
						case "subject":
							sStr_subject = elValue;
							break;		
						case "job":
							sStr_job = elValue;
							break;
						case "major":
							sStr_major = elValue;
							break;				
						default :
							argStr[argCnt] =  elName + "=" + elValue;
							argCnt ++;
							break;
					}				
				
			}else if (frm.elements[inx].type.toLowerCase() == "text"){
				switch (elName.toLowerCase()){
						case "userid":
							sStr_userid = elValue;
							break;
						case "username":
							sStr_username = elValue;
							break;
						case "userengname":
							sStr_userengname = elValue;
							break;
						case "foreign_username":
							sStr_foreign_username = elValue;
							break;
						case "comseq1":
							break;
						case "comseq2":
							break;
						case "comseq3":
							break;	
						case "birthday":
							sStr_birthday = elValue;
							break;
						case "zipcode":
							sStr_zipcode = elValue;
							break;
						case "addr_1":
							sStr_addr_1 = elValue;
							break;
						case "addr_2":
							sStr_addr_2 = elValue;
							break;
						case "phone_2":
							sTemp_Phone_2 = elValue;
							break;
						case "phone_3":
							sTemp_Phone_3 = elValue;
							break;
						case "fax_2":
							sTemp_Fax_2 = elValue;
							break;
						case "fax_3":
							sTemp_Fax_3 = elValue;
							break;
						case "hpno_2":
							sTemp_HP_2 = elValue;
							break;		
						case "hpno_3":
							sTemp_HP_3 = elValue;
							break;		
						case "email_1":
							sTemp_Email_1 = elValue;
							break;
						case "email_2":
							sTemp_Email_2 = elValue;
							break;	
						case "company":
							sStr_company = elValue;
							break;	
						case "branch":
							sStr_branch = elValue;
							break;	
						default :
							argStr[argCnt] =  elName + "=" + elValue;
							argCnt ++;
							break;
					}	
			}else if (frm.elements[inx].type.toLowerCase() == "hidden"){
				switch (elName.toLowerCase()){
						case "userpart":
							sStr_userpart = elValue;
							break;
						case "ssn_code":
							sStr_ssn_code = elValue;
							break;
						case "companyid":
							sStr_companyid = elValue;
							break;
						case "job":
							sStr_job = elValue;
							break;
						case "major":
							sStr_major = elValue;
							break;
						case "userid":
							sStr_userid = elValue;
							break;
						case "username":
							sStr_username = elValue;
							break;
						default :							
							break;
					}	
				
			}else{
				if(elName.toLowerCase() == "password")
					sStr_password = elValue;
			}
			
			*/
					
		}
		
		var argTempStr = "";
		if(argStr.length > 0) {
			for(var idx=0; idx < argStr.length; idx++){
				argTempStr += argStr[idx] + "&"
			}
			argTempStr = argTempStr.substring(0, argTempStr.length -1);
		}
		
		if(argTempStr !=""){
			as_returnUrl = as_returnUrl + "?" + argTempStr;
		}
		
		gs_returnURL = as_returnUrl;
			//header  i??e³´ Setting
		var now = new Date();
		var sDate = now.getDateString("YYYY-MM-DD hh:mm:ss");
		
		var requestTypeTextNode = xmlDoc.createTextNode(as_reqeustType);
		var requestDateTextNode = xmlDoc.createTextNode(sDate);
		var siteCodeTextNode = xmlDoc.createTextNode(as_siteCode);
		var returnURLTextNode = xmlDoc.createTextNode(as_returnUrl);
		
	
		if(sTemp_Phone != "") {
				sStr_phone = sTemp_Phone;
		} else {
			if(sTemp_Phone_2 != "" && sTemp_Phone_3 !="")  sStr_phone = sTemp_Phone_0 + "-" + sTemp_Phone_1 + "-" + sTemp_Phone_2 + "-" + sTemp_Phone_3;
		}
		
		if(sTemp_Fax != "") {
				sStr_fax = sTemp_Fax;
		} else {
			if(sTemp_Fax_2 != "" && sTemp_Fax_3 !="")  sStr_fax = sTemp_Fax_0 + "-" + sTemp_Fax_1 + "-" + sTemp_Fax_2 + "-" + sTemp_Fax_3;
		}
		
		if(sTemp_HP != "") {
				sStr_hpno = sTemp_HP;
		} else {
			if(sTemp_HP_2 != "" && sTemp_HP_3 !="")  sStr_hpno = sTemp_HP_0 + "-" + sTemp_HP_1 + "-" + sTemp_HP_2 + "-" + sTemp_HP_3;
		}
		
		if(sTemp_Email != "") {
				sStr_email = sTemp_Email;
		} else {
			if(sTemp_Email_1 != "" && sTemp_Email_2 !="")  sStr_email = sTemp_Email_1 + "@" + sTemp_Email_2;
		}
		
		var useridTextNode = xmlDoc.createTextNode(sStr_userid);
		if(sStr_userpart =="1"){
			var usernameTextNode = xmlDoc.createTextNode(sStr_foreign_username);
			var userengnameTextNode = xmlDoc.createTextNode(sStr_foreign_username);
		}			
		else {
			var usernameTextNode = xmlDoc.createTextNode(sStr_username);
			var userengnameTextNode = xmlDoc.createTextNode(sStr_userengname);
		}
		var passwordTextNode = xmlDoc.createTextNode(sStr_password);
		var companyidTextNode = xmlDoc.createTextNode(sStr_companyid);
		var companyTextNode = xmlDoc.createTextNode(sStr_company);
		var branchTextNode = xmlDoc.createTextNode(sStr_branch);
		var addrtypeTextNode = xmlDoc.createTextNode(sStr_addrtype);
		var phoneTextNode = xmlDoc.createTextNode(sStr_phone);
		var faxTextNode = xmlDoc.createTextNode(sStr_fax);
		var zipcodeTextNode = xmlDoc.createTextNode(sStr_zipcode);
		var addr_1TextNode = xmlDoc.createTextNode(sStr_addr_1);
		var addr_2TextNode= xmlDoc.createTextNode(sStr_addr_2);
		var emailTextNode = xmlDoc.createTextNode(sStr_email);
		var hpnoTextNode = xmlDoc.createTextNode(sStr_hpno);
		var mailflagTextNode = xmlDoc.createTextNode(sStr_mailflag);
		var smsflagTextNode = xmlDoc.createTextNode(sStr_smsflag);
		var ssn_codeTextNode = xmlDoc.createTextNode(sStr_ssn_code);
		var userpartTextNode = xmlDoc.createTextNode(sStr_userpart);
		var degreeTextNode = xmlDoc.createTextNode(sStr_degree);
		var majorTextNode = xmlDoc.createTextNode(sStr_major);
		var subjectTextNode = xmlDoc.createTextNode(sStr_subject);
		var jobTextNode = xmlDoc.createTextNode(sStr_job);
		var postTextNode = xmlDoc.createTextNode(sStr_post);
		var countryTextNode = xmlDoc.createTextNode(sStr_country);
		var birthdayTextNode = xmlDoc.createTextNode(sStr_birthday);
		var sexTextNode = xmlDoc.createTextNode(sStr_sex);
		
		var MetaDatanode = xmlDoc.createElement("metaData");
		var useridnode = xmlDoc.createElement("userid");
		var usernamenode = xmlDoc.createElement("username");
		var userengnamenode = xmlDoc.createElement("userengname");
		var passwordnode = xmlDoc.createElement("password");
		var companyidnode = xmlDoc.createElement("companyid");
		var companynode = xmlDoc.createElement("company");
		var branchnode = xmlDoc.createElement("branch");
		var addrtypenode = xmlDoc.createElement("addrtype");
		var phonenode = xmlDoc.createElement("phone");
		var faxnode = xmlDoc.createElement("fax");
		var zipcodenode = xmlDoc.createElement("zipcode");
		var addr_1node = xmlDoc.createElement("addr_1");
		var addr_2node= xmlDoc.createElement("addr_2");
		var emailnode = xmlDoc.createElement("email");
		var hpnonode = xmlDoc.createElement("hpno");
		var mailflagnode = xmlDoc.createElement("mailflag");
		var smsflagnode = xmlDoc.createElement("smsflag");
		var ssn_codenode = xmlDoc.createElement("ssn_code");
		var userpartnode = xmlDoc.createElement("userpart");
		var degreenode = xmlDoc.createElement("degree");
		var majornode = xmlDoc.createElement("major");
		var subjectnode = xmlDoc.createElement("subject");
		var jobnode = xmlDoc.createElement("job");
		var postnode = xmlDoc.createElement("post");
		var countrynode = xmlDoc.createElement("country");
		var birthdaynode = xmlDoc.createElement("birthday");
		var sexnode = xmlDoc.createElement("sex");
	
		RootNode.appendChild(Headernode);	
		Headernode.appendChild(requestTypenode);
		requestTypenode.appendChild(requestTypeTextNode);
		
		Headernode.appendChild(requestDatenode);
		requestDatenode.appendChild(requestDateTextNode);
		
		Headernode.appendChild(siteCodenode);
		siteCodenode.appendChild(siteCodeTextNode);
		
		Headernode.appendChild(returnURLnode);
		returnURLnode.appendChild(returnURLTextNode);
		
		//MetaData i??e³´ Setting
		RootNode.appendChild(MetaDatanode);	
		MetaDatanode.appendChild(useridnode);		
		useridnode.appendChild(useridTextNode);
		
		MetaDatanode.appendChild(usernamenode);
		usernamenode.appendChild(usernameTextNode);
		
		MetaDatanode.appendChild(userengnamenode);
		userengnamenode.appendChild(userengnameTextNode);
		
		MetaDatanode.appendChild(passwordnode);
		passwordnode.appendChild(passwordTextNode);
		
		MetaDatanode.appendChild(companyidnode);
		companyidnode.appendChild(companyidTextNode);
		
		MetaDatanode.appendChild(companynode);
		companynode.appendChild(companyTextNode);
		
		MetaDatanode.appendChild(branchnode);
		branchnode.appendChild(branchTextNode);
		
		MetaDatanode.appendChild(addrtypenode);
		addrtypenode.appendChild(addrtypeTextNode);
		
		MetaDatanode.appendChild(phonenode);
		phonenode.appendChild(phoneTextNode);
		
		MetaDatanode.appendChild(faxnode);
		faxnode.appendChild(faxTextNode);
		
		MetaDatanode.appendChild(zipcodenode);
		zipcodenode.appendChild(zipcodeTextNode);
		
		MetaDatanode.appendChild(addr_1node);
		addr_1node.appendChild(addr_1TextNode);
		
		MetaDatanode.appendChild(addr_2node);
		addr_2node.appendChild(addr_2TextNode);
		
		MetaDatanode.appendChild(emailnode);
		emailnode.appendChild(emailTextNode);
		
		MetaDatanode.appendChild(hpnonode);
		hpnonode.appendChild(hpnoTextNode);
		
		MetaDatanode.appendChild(mailflagnode);
		mailflagnode.appendChild(mailflagTextNode);
		
		MetaDatanode.appendChild(smsflagnode);
		smsflagnode.appendChild(smsflagTextNode);
		
		MetaDatanode.appendChild(ssn_codenode);
		ssn_codenode.appendChild(ssn_codeTextNode);
		
		MetaDatanode.appendChild(userpartnode);
		userpartnode.appendChild(userpartTextNode);
		
		MetaDatanode.appendChild(degreenode);
		degreenode.appendChild(degreeTextNode);
		
		MetaDatanode.appendChild(majornode);
		majornode.appendChild(majorTextNode);
		
		MetaDatanode.appendChild(subjectnode);
		subjectnode.appendChild(subjectTextNode);
		
		MetaDatanode.appendChild(jobnode);
		jobnode.appendChild(jobTextNode);
		
		MetaDatanode.appendChild(postnode);
		postnode.appendChild(postTextNode);
		
		MetaDatanode.appendChild(countrynode);
		countrynode.appendChild(countryTextNode);
		
		MetaDatanode.appendChild(birthdaynode);
		birthdaynode.appendChild(birthdayTextNode);
		
		MetaDatanode.appendChild(sexnode);
		sexnode.appendChild(sexTextNode);
		
		return xmlDoc.xml;
}



function gf_makeLoginForm(){
	var ofrm =  document.ssoLoginFrm;
	if(ofrm == null){
		var frmBody = "<form name='ssoLoginFrm' method='post'>";
		frmBody += "<input type='hidden' name='userid' value=''>";
		frmBody += "<input type='hidden' name='password' value=''>";
		frmBody += "<input type='hidden' name='returnURL' value=''>";
		frmBody += "<input type='hidden' name='server_num' value=''>";
		frmBody += "<input type='hidden' name='requestType' value=''>";
		frmBody += "</form>";
		document.body.insertAdjacentHTML("BeforeEnd", " " + frmBody + " ");
		ofrm =  document.ssoLoginFrm;
	}
	return ofrm;
}

function gf_makeiFrame(){
	
	var ifrm = document.getElementById("ssoifrm");
	if(ifrm == null) {
		var ifrmHTML = "<iframe name='ssoifrm' id='ssoifrm' src='' width='300' height='300' frameborder='1'></iframe>";
		//document.body.appendChild =  ifrmHTML;
		document.body.insertAdjacentHTML("BeforeEnd", " " + ifrmHTML + " ");
		ifrm = document.getElementById("ssoifrm");
	}
	return;
}

function gf_makeSSoForm(){
	var ofrm =  document.ssoFrm;
	if(ofrm == null){
		var frmBody = "<form name='ssoFrm' method='post'>";
		frmBody += "<input type='hidden' name='xmldata' value=''>";
		frmBody += "<input type='hidden' name='server_num' value=''>";
		frmBody += "<input type='hidden' name='requestType' value=''>";
		frmBody += "<input type='hidden' name='returnURL' value=''>";
		frmBody += "</form>";
		document.body.insertAdjacentHTML("BeforeEnd", " " + frmBody + " ");
		ofrm =  document.ssoFrm;
	}
	return ofrm;
}


