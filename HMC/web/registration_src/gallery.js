window.addEventListener("load",function(){
$("#first-choice2").hide();
$("#categeory").change(function(){
    var selected=$(this).children("option:selected").val();
    
    switch(selected)
    {
        case "student":
           $(".extra").show();
           $('#address').show();
           $("#first-choice2").hide();
            break;
        
        case "clerk":
            $(".extra").hide();
            $('#address').hide();
            break;
        case "mess_manager":
            $(".extra").hide();
            $('#address').hide();
            break;
        case "attendant_and_gardener":
            $(".extra").hide();
            $("#first-choice2").show();
            $('#address').hide();
            break;
        case "warden":
            $(".extra").hide();
            $("#first-choice").show();
            $('#address').hide();
            break;
        }
 });
});
if( document.refreshForm.visited.value == "" )
    {
        // This is a fresh page load
        document.refreshForm.visited.value = "1";
$("#categeory").selectedIndex="1";
        
        // You may want to add code here special for
        // fresh page loads
    }
    else
    {
        // This is a page refresh
$("#categeory").selectedIndex="1";
        
        // Insert code here representing what to do on
        // a refresh
    }
