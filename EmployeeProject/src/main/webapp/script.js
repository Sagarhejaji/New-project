document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.getElementById('toggleSidebar');
            const chevronLeft = toggleBtn.querySelector('.fa-chevron-left');
            const chevronRight = toggleBtn.querySelector('.fa-chevron-right');
            const body = document.body;

            toggleBtn.addEventListener('click', function() {
                sidebar.classList.toggle('collapsed');
                body.classList.toggle('sidebar-collapsed');
                chevronLeft.classList.toggle('show');
                chevronRight.classList.toggle('show');
            });
        });
        
        document.addEventListener('DOMContentLoaded', function() {
    const dropbtn = document.querySelector('.dropbtn');
    const dropdownContent = document.querySelector('.dropdown-content');

    dropbtn.addEventListener('click', function() {
        dropdownContent.classList.toggle('show');
    });

    window.addEventListener('click', function(event) {
        if (!event.target.matches('.dropbtn')) {
            if (dropdownContent.classList.contains('show')) {
                dropdownContent.classList.remove('show');
            }
        }
    });
});

function changePassword() {
    // Implement your change password logic here
    alert('Change password functionality to be implemented');
}





