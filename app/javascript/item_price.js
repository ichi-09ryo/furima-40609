window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  console.log(priceInput); // ここでpriceInputが正しく取得できているか確認
  
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      console.log(inputValue); // 入力値が正しく取得できているか確認
      
      const addTaxDom = document.getElementById("add-tax-price");
      console.log(addTaxDom); // addTaxDomが正しく取得できているか確認

      const profitDom = document.getElementById("profit");
      console.log(profitDom); // profitDomが正しく取得できているか確認

      // 販売手数料を計算
      const tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = tax;

      // 販売利益を計算
      const profit = inputValue - tax;
      profitDom.innerHTML = profit;
    });
  }
});