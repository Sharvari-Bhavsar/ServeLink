function toggleDropdown() {
  var dropdownContent = document.getElementById("dropdownContent");
  dropdownContent.classList.toggle("show");
}
function toggleDropdown2() {
  var dropdownContent = document.getElementById("dropdownContent2");
  dropdownContent.classList.toggle("show");
}


    function confirmLogout() {
        var confirmLogout = confirm("Are you sure you want to log out?");
        if (confirmLogout) {
            window.location.href = "logout.jsp"; // Redirect to logout page if confirmed
        } else {
            // Cancel logout
        }
    }

 