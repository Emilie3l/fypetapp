const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.fypet-navbar');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 90) {
        navbar.classList.add('fypet-navbar-colored');
      } else {
        navbar.classList.remove('fypet-navbar-colored');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };