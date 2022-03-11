<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티디아 우선심사 시스템</title>
<!-- jQuery UI CSS파일 -->
<link href="/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="/resources/css/tree/code.css" rel="stylesheet" type="text/css">
<link href="/resources/css/tree/ras.css" rel="stylesheet" type="text/css">
<script src="/js/dtree.js"></script>
<script type="text/javascript">

	//dtree, 현재 선택 메뉴, 현재 선택 레벨
	var m = new dTree('m'),
		curr_menu = "",
		curr_menu_lv = "";
	
	$(function(){
		
		//메뉴트리시작
		m.add(0,-1,'메뉴 목록',"javascript:fn_setMenu('','','','','','','N','','sm0')","top","top");
	
		//메뉴트리생성
		createMenu();
	
		//메뉴추가
		$('#add_btn').click(function(){
			fn_addMenu();
		});
		//메뉴추가
		$('#del_btn').click(function(){
			fn_delMenu();
		});
		
		//메뉴정보 변경
		$('.table-c').change(function(){
			if($('#save_type').val() != 'I' ){
				$('#save_type').val('U');
			}
		});
		//메뉴정보 변경
		$('input[type=checkbox]').change(function(){
			$('#rol_save_yn').val('U');
		});
		
		$('#menu_id').on("blur keyup", function() {
			$(this).val($(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ));
		});
		
	});
	
	//권한 체크 이벤트 
	function fn_chk(name,val){
	
		$('input[name='+ name +'][value='+ val +']').click();
	}
	
	
	/**
	 * 	메뉴 트리 생성
	 */
	function createMenu(){
		
		var procFn ="";
		var row_id="";
	
		$.ajax({
			    url : '/auth/readMenuList.do',
			    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
			    type : 'GET',
			    dataType : 'text',   //xml, html, script, json, jsonp, text
			    success : function(result) {
	           		var xmlObj = $(result);
		           	var sel_menu_id="";
		           	xmlObj.find('item').each(function(cnt){
			           			           		
		           		var obj = new Array();
		           		var menu_id = $(this).find('menu_id').text();
		           		var menu_nm = $(this).find('menu_nm').text();
		           		var menu_levl = $(this).find('menu_levl').text();
		           		var menu_prts_id = $(this).find('menu_prts_id').text();
		           		var menu_ord = $(this).find('menu_ord').text();
		           		var menu_url = $(this).find('menu_url').text();
		           		var menu_use_yn = $(this).find('menu_use_yn').text();
		           		var etc = $(this).find('etc').text();
			         
		           		var strFn = "fn_setMenu(";
		           			strFn += "'"+menu_id+"',";
		           			strFn += "'"+menu_nm.replace(/\'/gi,"\\'")+"',";
		           			strFn += "'"+menu_levl+"',";
		           			strFn += "'"+menu_prts_id+"',";
		           			strFn += "'"+menu_ord+"',";
		           			strFn += "'"+menu_url.replace(/\'/gi,"\\'")+"',";
		           			strFn += "'"+menu_use_yn+"',";
		           			strFn += "'"+etc+"',";
		           			strFn += "'sm"+Number(cnt+1) +"')";
		         		m.add(cnt+1, menu_levl, menu_nm , "javascript:"+strFn, menu_id, menu_prts_id);
			         		
		         		if(cnt == 0){
			           		if($('#sel_menu_id').val() != ""){
			           			sel_menu_id = $('#sel_menu_id').val();
			           		}else{
			           			sel_menu_id = menu_id;
			           		}	
		         		}
		         		if(procFn == ""){
			         		if(sel_menu_id == menu_id){
			         			curr_menu = menu_id;
			         			curr_menu_lv = menu_levl;
			         			procFn = strFn;
			         			row_id="sm"+Number(cnt+1);
			         		}
		         		}
		           	});
		           	var df = $('#dtreeDiv1').html(m.toString());
	
			    },
			    error : function() { // Ajax 전송 에러 발생시 실행
					alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			    },
			    complete : function(result) { // success, error 실행 후 최종적으로 실행
	
			    }
		});
		
	}
	
	/**
	 * 	메뉴 클릭 이벤트
	 */
	function fn_setMenu(){
		
		//저장하지 않고 이동하는 경우 확인창 
		if($('#save_type').val() == 'I' || $('#save_type').val() == 'U'
				|| $('#rol_save_yn').val() == 'I' || $('#rol_save_yn').val() == 'U' ){
			var strConfirm = confirm("저장하지 않은 정보가 있습니다.이동하시겠습니까?");
			if(!strConfirm){
				return;
			}
		}
	
		var sel_id =arguments[12];
		//선택트리 색변경
		$('.dTreeNode > a').attr('style','');
		$('#'+sel_id+'').attr('style','color:red');
		//전체 체크박스 해제
		$('input[type=checkbox]').prop('checked',false);
		
		$('#save_type').val('N');
		$('#menu_id').val(arguments[0]);
		$('#menu_id').prop('readonly','readonly');
		$('#menu_nm').val(arguments[1]);
		$('#menu_levl').val(arguments[2]);
		if(arguments[3] == '0'){
			$('#menu_prts_id').val('');
		}else{
			$('#menu_prts_id').val(arguments[3]);
		}
		$('#menu_ord').val(arguments[4]);
		$('#menu_url').val(arguments[5]);
		//$('input[name=menu_use_yn][value='+arguments[6]+']').prop('checked',true);
		$('#menu_use_yn').val(arguments[6]);
		
		var etc = arguments[7].split('<br>').join('\r\n');
		$('#etc').val(etc);
		curr_menu = arguments[0];
		curr_menu_lv = arguments[2];
		
		//코드 참조값1에서 보여주고 싶은 화면만 보이기 처리
		if(arguments[0] != ''){
			$('#auth_list > tr').attr('style','');
			
			$('#auth_list > tr').each(function(){
				
				if($(this).attr('name') != ''){
					if($(this).attr('name').indexOf(curr_menu) != -1){	
						$(this).attr('style','');
					}else{
						$(this).attr('style','display:none;');
					}
				}else{
					$(this).attr('style','');
				}
			});
			
		}
		//메뉴권한 불러오기
		if(arguments[0] != ''){
			//fn_readMenuRol(arguments[0]);
		}
		
		//메뉴용어 불러오기 --> 메뉴 url에 화면id등록
		//if(arguments[9] != ''){
		//	fn_readScMsg(arguments[0]);
		//}
		
	}
	
	/**
	* 로우 선택
	*/
	function fn_setRow(obj){
		$('#msgList .on').attr('class','off');
		$(obj).attr('class','on');	
	}
	
	// 메뉴 id 중복체크 
	function fn_MenuDupl_chk(param_id){
		var menu_id = $(param_id).val();
		
		if( menu_id == '' || menu_id == undefined){
			
			return;
		}
		
		if($("#save_type").val() != "I"){
			
			return;
		}
		
		$.ajax({
		    url : '/auth/duplChkMenuList.do',
		    data : {"menu_id": menu_id},   //전송파라미터
		    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
		    type : 'GET',
		    dataType : 'text',
		    success : function(result) {
		    	var rltObj = $(result);
	
	           if(rltObj.find("item").length > 0 ){  // 중복된 id가 존재하면 '1' 일테니 .. 
	        	    var kor_levl = ''; 
	        	    var menu_levl =  rltObj.find("item").find("menu_levl").text();    
	           		
	        	    if (menu_levl == 1 ){
						kor_levl = '하위메뉴 ID';          			           			
	           		}else if(menu_levl == 0){
	           			kor_levl = '상위메뉴 ID';
	           		}
	        	    
	        		//alert(kor_levl+ "값 중에 중복된 ID가 존재합니다.");
	        		alert("중복된 ID가 존재합니다.");
	        		$(param_id).val('');
	        		$(param_id).focus();
	           }
	  
		    },
		    error : function() { // Ajax 전송 에러 발생시 실행
		           alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
		    },
		    complete : function(result) { // success, error 실행 후 최종적으로 실행
		    	
		    }
		});
		
	}
	
	function fn_saveConfirm(){
		
		var param = new Array();
		
		if($('#menu_id').val() == ''){
			param[0]='menu_id';
			alert('메뉴 ID를 입력하세요');
			return;
		}
		if($('#menu_nm').val() == ''){
			param[0]='menu_nm';
			alert('메뉴명을 입력하세요.');
			return;
		}
	
		var msg = '저장하시겠습니까?';
		
		if(confirm(msg) == true){
			fn_save();
		}else{
		    return;
		}
	}
	
	/**
	 * 	메뉴 저장
	 */
	function fn_save(){
	
		var etc = $('#etc').val();
		etc = etc.replace(/(?:\r\n|\r|\n)/g, '<br>');
		$('#etc').val(etc);
		
		var form = document.form;
		form.action="/auth/saveMenu.do";
		form.submit();	
		
	}
	
	/**
	 * 	메뉴 추가
	 */
	function fn_addMenu(){
		
		$("#form")[0].reset();  
	
		$('#save_type').val('I');
		$('#menu_id').prop('readonly','');
		$('#menu_prts_id').val(curr_menu);
		
		if(curr_menu_lv == ""){
			$('#menu_levl').val('0');
		}else{
			$('#menu_levl').val(Number(curr_menu_lv)+1);
		}
		
	}
	
	/**
	 * 메뉴 삭제
	 */
	function fn_delMenu(){
		if( $('#menu_id').val() == '' && $('#menu_prts_id').val() == '' ){
			alert("메뉴정보가 없습니다.",'c');
			return;
		}
		var strConfirm = confirm($('#menu_nm').val() +"를 삭제하시겠습니까?\n(하위메뉴도 같이 삭제됩니다.)");
	
		if(strConfirm){
			var form = document.form;
			form.action="/auth/deleteMenu.do";
			form.submit();	
		}
	}
</script>
</head>
<body>
	<form id="form" name="form" method="post">
	<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
	
	<div class="title_name relative">
		<c:out value="${SS_ACTIVE_SUB_MENU_NM }" />
		<div class="navi absolute">
			<span><a href=""><img width="15" class="home_icon" src="/resources/images/home.png"></a></span>>
			<span><a href=""><c:out value="${SS_ACTIVE_TOP_MENU_NM }" /></a></span> > 
			<span><a href=""><c:out value="${SS_ACTIVE_SUB_MENU_NM }" /></a></span>
		</div>
	</div>
	
	<div class="box-blue-line">
		<div class="admin_left admin relative">
			<p class="menu_info"> 메뉴 정보(메뉴는 최대 4단계 이내로 생성해주세요)</p>
			<div class="menu_btn_box absolute">
				<input type="button" name="save_btn" id="add_btn" value="메뉴추가" class="boxshadow transition" />
				<input type="button" name="del_btn" id="del_btn" value="메뉴삭제" class="boxshadow transition" />
			</div>
			<br />
			<br />
			<div id="dtreeDiv1"></div>
		</div>
		<div class="admin_right admin">
				<input type="hidden" name="save_type" id="save_type" value="" />
				<input type="hidden" name="rol_save_yn" id="rol_save_yn" value="" />
				<input type="hidden" id="menu_rol_list" name="menu_rol_list" value="" />
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 상위메뉴 ID</span>
					</div>
				</div>
				<div class="input_div clear">	
					<input type="text" class="jakyeokjeung"  id="menu_prts_id" name="menu_prts_id" readonly="readonly" />
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 메뉴레벨</span>
					</div>
				</div>
				<div class="input_div clear">	
					<input type="text" class="jakyeokjeung"  id="menu_levl" name="menu_levl" readonly="readonly" />
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 메뉴 ID</span>
					</div>
				</div>
				<div class="input_div clear">	
					<input type="text" class="jakyeokjeung"  id="menu_id" name="menu_id" onblur="fn_MenuDupl_chk(this)" />
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 메뉴명</span>
					</div>
				</div>
				<div class="input_div clear">	
					<input type="text" class="jakyeokjeung"  id="menu_nm" name="menu_nm" />
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 메뉴URL</span>
					</div>
				</div>
				<div class="input_div clear">	
					<input type="text" class="jakyeokjeung"  id="menu_url" name="menu_url" />
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 메뉴순서</span>
					</div>
				</div>
				<div class="input_div clear">	
					<input type="text" class="jakyeokjeung"  id="menu_ord" name="menu_ord" />
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 사용여부</span>
					</div>
				</div>
				<div class="input_div clear">	
					<select id="menu_use_yn" name="menu_use_yn" style="margin-bottom: 12px;">
						<option value="Y">사용</option>
						<option value="N">미사용</option>
					</select>
				</div>
				
				<div class="input_div clear">
					<div class="input_name">
						<span class="circle"> 설명</span>
					</div>
				</div>
				<div class="input_div clear">
					<textarea name="etc" id="etc" style=" height: 75px;"></textarea>
				</div>
			
			<!-- 버튼 -->
			<div align="center">
<!-- 				<button type="button" class="submit" style="width: 70px; margin-top:20px;" onclick="javascript:fn_saveConfirm();">저장</button> -->
				<button type="button" class="submit" onclick="javascript:fn_saveConfirm();">저장</button>
			</div>
		</div>
	</div>
	</form>
</body>
</html>