/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $('#addButton').click(function(){
        var text = $('#inputIngr').val();
        if(text != ""){
        $('#ingredience').append('<a class="x"><span class ="label">'+ text +'</span><i class="icon-remove"></a>');
        $('#inputIngr').val("");
        }
    });
});

$(document).ready(function(){
    $('.x').live('click', function(){
        $(this).remove();
    }); 
});

$(document).ready(function(){
    $('#star1').mouseover(function(){
        $('#star1').attr({class: "btn btn-small btn-warning"});
    });
    $('#star1').mouseout(function(){
        $('#star1').attr({class: "btn btn-small"});
    });
    $('#star2').mouseover(function(){
        $('#star1').attr({class: "btn btn-small btn-warning"});
        $('#star2').attr({class: "btn btn-small btn-warning"});
    });
    $('#star2').mouseout(function(){
        $('#star1').attr({class: "btn btn-small"});
        $('#star2').attr({class: "btn btn-small"});
    });
    $('#star3').mouseover(function(){
        $('#star1').attr({class: "btn btn-small btn-warning"});
        $('#star2').attr({class: "btn btn-small btn-warning"});
        $('#star3').attr({class: "btn btn-small btn-warning"});
    });
    $('#star3').mouseout(function(){
        $('#star1').attr({class: "btn btn-small"});
        $('#star2').attr({class: "btn btn-small"});
        $('#star3').attr({class: "btn btn-small"});
    });
    $('#star4').mouseover(function(){
        $('#star1').attr({class: "btn btn-small btn-warning"});
        $('#star2').attr({class: "btn btn-small btn-warning"});
        $('#star3').attr({class: "btn btn-small btn-warning"});
        $('#star4').attr({class: "btn btn-small btn-warning"});
    });
    $('#star4').mouseout(function(){
        $('#star1').attr({class: "btn btn-small"});
        $('#star2').attr({class: "btn btn-small"});
        $('#star3').attr({class: "btn btn-small"});
        $('#star4').attr({class: "btn btn-small"});
    });
    $('#star5').mouseover(function(){
        $('#star1').attr({class: "btn btn-small btn-warning"});
        $('#star2').attr({class: "btn btn-small btn-warning"});
        $('#star3').attr({class: "btn btn-small btn-warning"});
        $('#star4').attr({class: "btn btn-small btn-warning"});
        $('#star5').attr({class: "btn btn-small btn-warning"});
    });
    $('#star5').mouseout(function(){
        $('#star1').attr({class: "btn btn-small"});
        $('#star2').attr({class: "btn btn-small"});
        $('#star3').attr({class: "btn btn-small"});
        $('#star4').attr({class: "btn btn-small"});
        $('#star5').attr({class: "btn btn-small"});
    });
    
    $('#star1').click(function(){
       window.alert("Vaše hodnocení: 1"); 
    });
    $('#star2').click(function(){
       window.alert("Vaše hodnocení: 2"); 
    });
    $('#star3').click(function(){
       window.alert("Vaše hodnocení: 3"); 
    });
    $('#star4').click(function(){
       window.alert("Vaše hodnocení: 4"); 
    });
    $('#star5').click(function(){
       window.alert("Vaše hodnocení: 5"); 
    });
});


