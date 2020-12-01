const initEnableDisableReward = () => {
  const reward_offered = document.querySelector('#report_reward_offered');
  if (reward_offered) {
    window.addEventListener('click', () => {
      const reward_amount = document.querySelector('#report_reward_amount');
      if (reward_amount) {
        if (reward_offered.checked) {
          reward_amount.disabled = false;
        } else {
          reward_amount.disabled = true;
        }
      }
    });
  }
}

export { initEnableDisableReward };