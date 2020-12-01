function filterCards() {
  const formPetFilter = document.getElementById('pet_filter');
    formPetFilter.querySelectorAll('select').forEach((filter) => {
      filter.addEventListener('change', (event) => {
      formPetFilter.submit();
    });
  })
}

export { filterCards };
