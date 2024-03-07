$(document).ready(function() {
    /* Cargar colores al editar un producto */
    let listColors = $("#product_color").val();
    if (listColors !== "" && listColors !== undefined) {
        let arrayColors = listColors.split(",");
        $("#product_color").val("");

        arrayColors.forEach((idColor) => {
            $("#product_colores").val(idColor);
            colorSelected($("#product_colores")[0]);
        }) 
    }

    // let navPage =$(".pagy-bootstrap-nav");
    // let listPage =$(".pagination");
    // let itemPage =$(".pagination li");
    // let linkPage =$(".pagination li a");
    // let activePage =$(".pagy-bootstrap-nav .pagination .page-item.active a");
    // let parentActivePage = activePage.parent();
    // navPage.addClass("pagination-items");
    // listPage.addClass("justify-content-center mb--0");
    // itemPage.removeClass("page-item");
    // linkPage.removeClass("page-link");
    // activePage.addClass("active");
    // parentActivePage.removeClass("active");
});

inputsCalculate = document.getElementsByClassName('calculate-total-price');
inputsArray = Array.from(inputsCalculate);

inputsArray.forEach((element) => {
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

/* List Colors */

const colorSelected = (select) => {
    let index = select.selectedIndex;
    let option = select.options[index];
    let idColor = option.value;
    let color = option.text;

    option.disabled = "disabled";
    select.selectedIndex = 0;

    agregarColor(idColor, color);

    let listColors = $("#product_color").val();

    if (listColors == "") {
        $("#product_color").val(idColor);
    } else {
        $("#product_color").val(listColors + "," + idColor);
    }
}

const agregarColor = (idColor, color) => {
    let htmlString = `
        <li data-bg-color="${idColor}" style="background-color: ${idColor}" title="${color}" onclick="eliminarColor(this)"></li>
    `

    $("#color-list").append(htmlString);
}

const eliminarColor = (eColor) => {
    let bgColor = eColor.dataset.bgColor;
    let arrayColors = $("#product_color").val().split(",").filter(color => color !== bgColor);

    $("#product_color").val(arrayColors.join(","));

    $("product_colores option[value='" + bgColor + "']").removeAttr("disabled");

    $(eColor).remove();
}

const redirectToPage = (selectElement) => {
    var selectedOption = selectElement.value;
    if (selectedOption) {
        window.location.href = selectedOption;
    }
}