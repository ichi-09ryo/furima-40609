function formatNumber(num) {
  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function setupPriceCalculation() {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      const profitDom = document.getElementById("profit");

      // 販売手数料を計算
      const tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = formatNumber(tax);

      // 販売利益を計算
      const profit = inputValue - tax;
      profitDom.innerHTML = formatNumber(profit);
    });
  }
}

document.addEventListener('turbo:load', setupPriceCalculation);
document.addEventListener('DOMContentLoaded', setupPriceCalculation);