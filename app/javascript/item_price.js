// app/javascript/item_price.js
window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      const profitDom = document.getElementById("profit");

      // 販売手数料を計算
      const tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = tax;

      // 販売利益を計算
      const profit = inputValue - tax;
      profitDom.innerHTML = profit;
    });
  }
});