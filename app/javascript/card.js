document.addEventListener("DOMContentLoaded", () => {
  if (document.getElementById("charge-form")) {
    const payjpPublicKey = gon.payjp_public_key;  // Payjp公開鍵を取得
    Payjp.setPublicKey(payjpPublicKey);

    const form = document.getElementById("charge-form");

    form.addEventListener("submit", (e) => {
      e.preventDefault();

      const card = {
        number: document.getElementById("card-number").value,
        cvc: document.getElementById("card-cvc").value,
        exp_month: document.getElementById("card-exp-month").value,
        exp_year: document.getElementById("card-exp-year").value,
      };

      Payjp.createToken(card, (status, response) => {
        if (status === 200) {
          const token = response.id;
          const tokenObj = `<input value=${token} name='item_order[token]' type="hidden">`;
          form.insertAdjacentHTML("beforeend", tokenObj);

          // カード情報を削除して送信
          document.getElementById("card-number").removeAttribute("name");
          document.getElementById("card-cvc").removeAttribute("name");
          document.getElementById("card-exp-month").removeAttribute("name");
          document.getElementById("card-exp-year").removeAttribute("name");

          form.submit();
        } else {
          alert("カード情報が正しくありません。");
        }
      });
    });
  }
});