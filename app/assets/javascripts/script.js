
inputsCalculate = document.getElementsByClassName('calculate-total-price');
inputsArray = Array.from(inputsCalculate);

inputsArray.forEach((element) => {
    console.log(element);
    element.addEventListener('input', function() {

        let price = parseFloat(document.getElementById('product_price').value);
        let discount = parseFloat(document.getElementById('product_discount').value);
        let totalPrice = document.getElementById('product_total_price');
        
        if (!isNaN(price) && !isNaN(discount)) {

            var total_discount = price * (discount/100);
            var result = price - total_discount;
            
            totalPrice.value = result;

        } else {
            totalPrice.value = '';
        }

    });
});


