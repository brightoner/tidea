tinyMCE.init({
    // General options
    mode : "exact",
    elements : "content,introduction,editorialBoard,authorGuide,reviewerGuide",
    theme : "advanced",
    skin : "o2k7",
    skin_variant : "silver",
    plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,iespell,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,noneditable,visualchars,nonbreaking,xhtmlxtras,template,inlinepopups,autosave",

    // Theme options
    theme_advanced_buttons1 : "code,|,preview,|,undo,redo,|,fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,sub,sup,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,ltr,rtl,|,print,",
    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,outdent,indent,blockquote,hr,|,link,unlink,anchor,image,charmap,|,forecolor,backcolor,|,tablecontrols,",
    theme_advanced_buttons3 : "",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "bottom",
    theme_advanced_resizing : false,

    // Example content CSS (should be your site CSS)
    content_css : "css/content.css",

    // Drop lists for link/image/media/template dialogs
    template_external_list_url : "lists/template_list.js",
    external_link_list_url : "lists/link_list.js",
    external_image_list_url : "lists/image_list.js",
    media_external_list_url : "lists/media_list.js",

    // Replace values for the template plugin
    template_replace_values : {
        username : "Some User",
        staffid : "991234"
    }
});