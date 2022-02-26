/* ccl 적용시 동적으로 바뀌는 버젼 문구를 위한 스크립트 파일 */
var objCCLcountry = {	none: "3.0", ar : "2.5",	 au : "3.0",	 at : "3.0",	 be : "2.0",	 br : "3.0",
	 bg : "2.5",
	 ca : "2.5",
	 cl : "3.0",
	 cn : "3.0",
	 co : "2.5",
	 cr : "3.0",
	 hr : "3.0",
	 cz : "3.0",
	 dk : "2.5",
	 ec : "3.0",
	 eg : "3.0",
	 ee : "3.0",
	 fi : "1.0",
	 fr : "3.0",
	 de : "3.0",
	 gr : "3.0",
	 gt : "3.0",
	 hk : "3.0",
	 hu : "2.5",
	 ind : "2.5",
	 ie : "3.0",
	 il : "2.5",
	 it : "3.0",
	 jp : "2.1",
	 lu : "3.0",
	 mk : "2.5",
	 my : "2.5",
	 mt : "2.5",
	 mx : "2.5",
	 nl : "3.0",
	 nz : "3.0",
	 no : "3.0",
	 pe : "2.5",
	 ph : "3.0",
	 pl : "3.0",
	 pt : "3.0",
	 pr : "3.0",
	 ro : "3.0",
	 rs : "3.0",
	 sg : "3.0",
	 si : "2.5",
	 za : "2.5",
	 kr : "2.0",
	 es : "3.0",
	 se : "2.5",
	 ch : "3.0",
	 tw : "3.0",
	 th : "3.0",
	 uk : "2.0",
	 scotland : "2.5",
	 ug : "3.0",
	 us : "3.0",
	 vn : "3.0"};

var arel = '<a rel="license" target="_blank" href="http://creativecommons.org/licenses/';

function makeCCLtextarea(cclcode,codevserion,attribution,select_txt,rep_select_val,total_txt){
	
	var title_src = "This work";
	var source_url = "";
	var perimt_url = "";
	
	if(total_txt["title"] != ""){
		title_src = '<br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">'+total_txt["title"]+'</span>';
	}
	
	if(total_txt["name"] != ""){
		if(total_txt["url_"] != ""){
			title_src += ' by <a xmlns:cc="http://creativecommons.org/ns#"  href="'+total_txt["url_"]+'" property="cc:attributionName" rel="cc:attributionURL" >'+total_txt["name"]+'</a>';
		}else{
			title_src += ' by <span xmlns:cc="http://creativecommons.org/ns#"  property="cc:attributionName">'+total_txt["name"]+'</span>';
		}
	}else{
		if(total_txt["url_"] != ""){
			title_src += ' by <a xmlns:cc="http://creativecommons.org/ns#"  href="'+total_txt["url_"]+'" property="cc:attributionName" rel="cc:attributionURL" >'+total_txt["url_"]+'</a>';
		}
	}
	
	if(total_txt["sourceurl_"] != ""){
		source_url = '<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="'+total_txt["sourceurl_"]+'" rel="dct:source">'+total_txt["sourceurl_"]+'</a>';
	}
	
	if(total_txt["permiurl_"] != ""){
		perimt_url = '<br />Permissions beyond the scope of this license may be available at '+
						'<a xmlns:cc="http://creativecommons.org/ns#" href="'+total_txt["permiurl_"]+'" rel="cc:morePermissions">'+total_txt["permiurl_"]+'</a>';
	}
	
//	alert(rep_select_val);
	var txt_area = arel+cclcode+'/'+codevserion+'/'+rep_select_val+'">'+
	'<img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/'+cclcode+'/'+codevserion+'/88x31.png" /></a>'+
	title_src+' is licensed under a '+ 
	arel+cclcode+'/'+codevserion+'/'+rep_select_val+'">Creative Commons '+attribution+' '+codevserion+' '+select_txt+' License</a>'+source_url+perimt_url+'.';
	
	return txt_area;
}


String.prototype.replaceAll = function(str1,str2){
	var str = this;
	var resultTxt = str.replace(eval("/"+str1+"/gi"), str2);
	
	return resultTxt;
};


function cclcountry2(code){
	
	for(code in obj){
		if(obj.hasOwnProperty(code)){
			alert (obj[code]);
		}	
	}
	return obj[code];
	
}

