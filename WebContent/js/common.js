
if(window.parent.name=='pop' || window.parent.name=='pop1'){
	 self.resizeTo(800, 800);
}

function goSubmit(form) {
	form.submit();
	pageLoadingShow();
}

// 유효한 문자체크(특수문자나 공백을 아이디로 사용할수 없게하도록 할때 사용)
function CheckChar(str) {
	len=str.value.length;
	for (i=0;i<len;i++) {
		if (str.value.charAt(i)==" " || str.value.charAt(i)=='"' || str.value.charAt(i)=="'" || str.value.charAt(i)=="%" || str.value.charAt(i)=="\"" || str.value.charAt(i)=="&" )	{
			alert("The Character format is invalid");
			str.focus();
			return false;
		}
	}
	return true;
}

// checking email form
function CheckMail(email) {
	
	mailRegxp = /^[\w-_.]+@[\w-_]+(\.[\w-_]+){1,4}$/;
	if ( !mailRegxp.test(email) ) {
		alert("The Email format is invalid");
		return false;
	}
	
	return true;
}

// 문자열의 모든 공백을 제거
function CheckSpaceAll(str) {
	var index;
	var len;

	while(true) {
		index=str.value.indexOf(" ");
		if (index==-1) break;
		len=str.value.length;
		str.value=str.value.substring(0,index) + str.value.substring((index+1),len)
	}
	return str.value;
}

// 문자열 앞뒤의 공백을 제거
function CheckSpace(str) {
	var len;
	
	while(true) {
		if (str.value.charAt(0) != " ") break;
		len=str.value.length;
		str.value=str.value.substring(1,len);
	}

	while(true) {
		len=str.value.length;
		if (str.value.charAt(len-1) != " ") break;
		str.value=str.value.substring(0,len-1);
	}

	return str.value;
}

// 공백인지 체크
function isEmpty(data) {
	for (var i=0;i <  data.length; i++)
		if(data.substring(i,i+1) != " ") return false;
	return true;
}

// 숫자인지 체크
function isNumber(data) {
	if (parseInt(data)) {
		return true;
	}
	return false;
}

// 숫자만 허용하도록 체크
function checkNum(obj, e) {
	// 키보드를 누른후에 체크
  	if ( e.type == 'keyup') {
		var whichCode = e.keyCode;

		// 숫자범위 0 ~ 9
		if ( !((whichCode >= 48) && (whichCode <= 57))) {

			// 키패드의 숫자범위 0 ~ 9
			if ( !((whichCode >= 96) && (whichCode <= 105))) {

				// 백스패이스와 삭제키, 마우스클릭은 제외
				if ( !((whichCode == 8) || (whichCode == 46) || (whichCode == 229))) {
					alert("only input number!");
					obj.value = "";
				}
			}
		}
	}
}

// 두문자열이 같은지를 체크
function CheckPW(str1,str2) {
	if (str1 != str2) {
		return false;
	}else{
		return true;
	}
}

// GetCookie
function getCookie(name){
	var namestr   = name + "=";
	var namelen   = namestr.length;
	var cookielen = document.cookie.length;

	var i    = 0;
	while(i< cookielen){
		var j = i+namelen;
		if(document.cookie.substring(i,j)==namestr){
			var end = document.cookie.indexOf(";",j);
			if(end== -1)
				end = document.cookie.length;
			return unescape(document.cookie.substring(j,end));
		}
		i=document.cookie.indexOf(" ",i)+1;
		if (i==0) break;
	}
	return null;
}

// Set Cookie
function setCookie(name,value){
	var expires = new Date();
	var path,domain,secure;

	var argv    = setCookie.arguments; 
	var argc    = setCookie.arguments.length;  
	if (argc > 2) {
		expires.setTime(expires.getTime() + (1000*60*argv[2]));
	} 
	else {
		expires  = null;
	}
	path    = (argc > 3) ? argv[3] : null;  
	domain  = (argc > 4) ? argv[4] : null;  
	secure  = (argc > 5) ? argv[5] : false;  
	document.cookie = name + "=" + escape (value) + 
		((expires == null) ? ""         : ("; expires=" + expires.toGMTString())) + 
		((path    == null) ? ""         : ("; path=" + path)) +  
		((domain  == null) ? ""         : ("; domain=" + domain)) +    
		((secure  == true) ? "; secure" : "");
							
}

/**
 * 2012-03-26 기능고도화 추가
 * 
 */
function textAreaToText(inputName1, inputName2, formName, refTable, cssType1){
	var val = document.getElementById(inputName1).value;
	var arr = val.split("\n");
	if(arr.length > eval("document."+formName+"."+inputName2).length){
		var cnt = arr.length - eval("document."+formName+"."+inputName2).length;
		for(var i=0; i<cnt; i++){
			addRefInput(refTable, inputName2, cssType1);	
		}
	}else if(eval("document."+formName+"."+inputName2).length == undefined){
		if(arr.length > 1){
			for(var i=1; i<arr.length; i++){
				if(arr[i] != ""){
					addRefInput(refTable, inputName2, cssType1);
				}
			}
		}
	}
	if(eval("document."+formName+"."+inputName2).length == undefined){
		eval("document."+formName+"."+inputName2).value = arr[0];
	}else{
		for(var a=0; a < arr.length; a++){
			if(arr[a].split(" ").join() != ""){
				eval("document."+formName+"."+inputName2)[a].value = arr[a];
			}
		}
	}
}

function textToTextArea(inputName1, inputName2, formName){
	var val = "";
	if(eval("document."+formName+"."+inputName2).length == undefined){
		val = eval("document."+formName+"."+inputName2).value;
	}else{
		for(var i=0; i<eval("document."+formName+"."+inputName2).length; i++){
			var val1 = eval("document."+formName+"."+inputName2)[i].value;
			if(val1.split(" ").join() != ""){
				if(val == ""){
					val = val1;
				}else{
					val = val + "\n" + val1;
				}
			}
		}
	}
	document.getElementById(inputName1).value = val;
}


function addRefInput(refTable, references, cssType1) {
	var refTableObj = document.getElementById(refTable);
	var newTr = refTableObj.insertRow(-1, document.createElement('tr'));
	var newTd = newTr.insertCell(-1, document.createElement('td'));
	newTd.setAttribute = 'width="95%"';
	newTd.innerHTML = '<input type="text" name="'+references+'" class="'+cssType1+'" />';
	newTd = newTr.insertCell(-1, document.createElement('td'));
	newTd.setAttribute = 'width="5%"';
	newTd.innerHTML = '<a href="#" onclick="deleteRefInput(this); return false;"><b>[Delete]</b></a>';
}

function deleteRefInput(obj) {
    refTable.deleteRow(obj.parentNode.parentNode.rowIndex);
}

function textAreaToText2(inputName1, inputName2, formName, refTable){
	var val = document.getElementById(inputName1).value;
	var arr = val.split("\n");
	if(arr.length > eval("document."+formName+"."+inputName2).length){
		var cnt = arr.length - eval("document."+formName+"."+inputName2).length;
		for(var i=0; i<cnt; i++){
			addRefInput2(refTable, inputName2);	
		}
	}else if(eval("document."+formName+"."+inputName2).length == undefined){
		if(arr.length > 1){
			for(var i=1; i<arr.length; i++){
				if(arr[i] != ""){
					addRefInput(refTable, inputName2, cssType1);
				}
			}
		}
	}

	if(eval("document."+formName+"."+inputName2).length == undefined){
		eval("document."+formName+"."+inputName2).value = arr[0];
	}else{
		for(var a=0; a < arr.length; a++){
			if(arr[a].split(" ").join() != ""){
				eval("document."+formName+"."+inputName2)[a].value = arr[a];
			}
		}
	}
}

function textToTextArea2(inputName1, inputName2, formName){
	var val = "";
	if(eval("document."+formName+"."+inputName2).length == undefined){
		val = eval("document."+formName+"."+inputName2).value;
	}else{
		for(var i=0; i<eval("document."+formName+"."+inputName2).length; i++){
			var val1 = eval("document."+formName+"."+inputName2)[i].value;
			if(val1.split(" ").join() != ""){
				if(val == ""){
					val = val1;
				}else{
					val = val + "\n" + val1;
				}
			}
		}
	}
	document.getElementById(inputName1).value = val;
}


function addRefInput2(refTable, references) {
	var refTableObj = document.getElementById(refTable);
	var newTr = refTableObj.insertRow(-1, document.createElement('tr'));
	var newTd = newTr.insertCell(-1, document.createElement('td'));
	newTd.setAttribute = 'width="95%"';
	newTd.innerHTML = '<input type="text" name="'+references+'" size="85%" />';
	newTd = newTr.insertCell(-1, document.createElement('td'));
	newTd.setAttribute = 'width="5%"';
	newTd.innerHTML = '<a href="#" onclick="deleteRefInput2(this); return false;"><b>[Delete]</b></a>';
}

function deleteRefInput2(obj) {
    refTable.deleteRow(obj.parentNode.parentNode.rowIndex);
}

// 숫자만 입력
function checkDigit(totalPage){
	if($(totalPage).val() != "" && $(totalPage).val().match(/[^0-9]/g) != null){
		$(totalPage).val($(totalPage).val().replace(/[^0-9]/g, ''));
		$(totalPage).focus();
	}
}
/*시작일- 종료일 체크*/
function date_check(obj){
		
		var name = obj.name ;
		var date = obj.value;
		var start = "";
		var end = "";
		
        if(name == "FONDDE" || name == "BGNDE" || name=="DGRI_BGNDE" || name == "SRBDE" || name=="PRTC_BGNDE" || name=="SEARCH_INSPCTDE_FROM"){
        	start = obj.value;
        	if(name == "FONDDE"){
        		end = $("input[name=ABLDE]").val();
        	}else if(name == "BGNDE"){
        		end = $("input[name=ENDDE]").val();
        	}else if(name == "DGRI_BGNDE"){
        		end = $("input[name=DGRI_ENDDE]").val();
        	}else if(name == "SRBDE"){
        		end = $("input[name=SECSNDE]").val();
        	}else if(name == "PRTC_BGNDE"){
        		end = $("input[name=PRTC_ENDDE]").val();
        	}else if(name == "SEARCH_INSPCTDE_FROM"){
        		end = $("input[name=SEARCH_INSPCTDE_TO]").val();
        	}
        	if(end == null || end == ""){
        		obj.value = date;
        	}else{
        		if(start > end){
        			alert("[시작일]이 종료일보다 큽니다.");
        			obj.value = "";
        		}else{
        			obj.value = date;
        		}
        	}
        }else if(name == "ABLDE" || name == "ENDDE" || name =="SECSNDE" || name=="DGRI_ENDDE" || name =="PRTC_ENDDE" || name=="SEARCH_INSPCTDE_TO"){
        	if(name == "ABLDE"){
        		start = $("input[name=FONDDE]").val();
        	}else if(name == "ENDDE"){
        		start = $("input[name=BGNDE]").val();
        	}else if(name == "DGRI_ENDDE"){
        		start = $("input[name=DGRI_BGNDE]").val();
        	}else if(name == "SECSNDE"){
        		start = $("input[name=SRBDE]").val();
        	}else if(name == "PRTC_ENDDE"){
        		start = $("input[name=PRTC_BGNDE]").val();
        	}else if(name == "SEARCH_INSPCTDE_TO"){
        		start = $("input[name=SEARCH_INSPCTDE_FROM]").val();
        	}
        	end = obj.value;
        	if(start == null || start == ""){
        		obj.value = date;
        	}else{
        		if(start > end){
        			alert("[종료일]이 시작일 보다 작습니다.");
        			obj.value = "";
        		}else{
        			obj.value = date;
        		}
        	}
        }
		
	
}

/* 날짜 포맷 세팅 */
function date_format(obj) {
	if ( obj.value == "" || obj.value == null ) {
		return;
	} else {
		var date = obj.value ;

        if (isVaildDate(date)) {
			if ( date.length == 8 ) {
				obj.value = date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8);
			}
        } else {
            //obj.select();
            //obj.focus();
            setTimeout(function(){ obj.focus(); }, 10);
        }   
	}
}

/* 날짜 유효성 체크 */
function isVaildDate(value)  {

	var chkDate = replace(value,"-","");
	if ( chkDate.length != 8 ) {
		alert(chkDate+"는  유효한 날짜가 아닙니다. 다시 입력해주세요");
		return false;
	}
	
	var yy = chkDate.substring(0,4);
	var mm = chkDate.substring(4,6);
	var dd = chkDate.substring(6,8);
	--mm;
	
	var dateVar = new Date(yy, mm, dd);
	//인수로 받은 년월일과 생성한 Date객체의 년월일이 일치하면 true
	if ( dateVar.getFullYear()==yy && dateVar.getMonth()==mm && dateVar.getDate()==dd ) {
		return true;
	} else {
		alert(chkDate+"는 유효한 날짜가 아닙니다. 다시 입력해 주세요");
		return false;
	}
}

/*  문자열에 있는 특정문자패턴을 다른 문자패턴으로 바꾸는 함수.  */
function replace(targetStr, searchStr, replaceStr)
{
	var len, i, tmpstr;

	len = targetStr.length;
	tmpstr = "";

	for ( i = 0 ; i < len ; i++ ) {
		if ( targetStr.charAt(i) != searchStr ) {
			tmpstr = tmpstr + targetStr.charAt(i);
		}
		else {
			tmpstr = tmpstr + replaceStr;
		}
	}
	return tmpstr;
}

// 로딩바
function pageLoadingShow() {
	
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();
    var maskWidth = $(document).width();
     
    var mask = "<div id='mask' style='position:absolute; z-index:9000; display:none; left:0; top:0;'></div>"; //background-color:#aaaaaa;
    var loadingImg = '';
    
    var top = '50%';
    var left = '50%';
    
//    loadingImg += "<div id='loadingImg' style='position:absolute; left:" + left + "; top:" + top + ";'>";
//    loadingImg += "<img src='/images/loading.gif' />";
//    loadingImg += "</div>";  
    loadingImg += '<div class="loading" id="loadingImg">';
    loadingImg += '<div class="spin">';
    	loadingImg += '<span class="spin1"><img src="/resources/images/loading1.png"></span>';
		loadingImg += '<span class="spin2"><img src="/resources/images/loading2.png"></span>';
		loadingImg += '<span class="spin3"><img src="/resources/images/loading3.png"></span>';
		loadingImg += '<span class="spin4"><img src="/resources/images/loading4.png"></span>';
		loadingImg += '<span class="spin5"><img src="/resources/images/loading5.png"></span>';
		loadingImg += '<span class="spin6"><img src="/resources/images/loading6.png"></span>';
		loadingImg += '</div>';
	loadingImg += '</div>';
 
    //화면에 레이어 추가
    $('body')
        .append(mask)
        .append(loadingImg)
       
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({
		'width' : maskWidth,
		'height': maskHeight,
		'opacity' : '0.3' //0.3
    }); 
 
	//마스크 표시
    $('#mask').show();   
 
    //로딩중 이미지 표시
    $('#loadingImg').show();
}

function pageLoadingHide(){
	//마스크 표시 해제
    $('#mask').remove();
 
    //로딩중 이미지 표시 해제
    $('#loadingImg').remove();
}
