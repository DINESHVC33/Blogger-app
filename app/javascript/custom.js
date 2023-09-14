document.addEventListener("DOMContentLoaded", function () {
    const showCommentsLinks = document.querySelectorAll(".show-comments-link");

    showCommentsLinks.forEach((link) => {
        link.addEventListener("click", function () {
            const targetId = this.getAttribute("data-target");
            const targetComments = document.getElementById(targetId);

            if (targetComments.style.display === "none" || targetComments.style.display === "") {
                targetComments.style.display = "block";
            } else {
                targetComments.style.display = "none";
            }
        });
    });
});
