$(document).ready(function(){
  /* FROM https://github.com/ColinFay/hexmake/blob/707c0890ebd42ed8656855e76341966270477572/inst/app/www/script.js */
  const details = document.querySelectorAll("details");
  details.forEach((targetDetail) => {
    targetDetail.addEventListener("click", () => {
      details.forEach((detail) => {
        if (detail !== targetDetail) {
          detail.removeAttribute("open");
        }
      });
    });
  });
});
