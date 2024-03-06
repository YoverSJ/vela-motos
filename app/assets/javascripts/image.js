
const previewImage = () => {

    let fileReader = new FileReader();
    let inputFile = document.getElementById("file_image");
    let maxImageWidth = 800; // Definir el ancho máximo permitido
    let maxImageHeight = 800; // Definir el alto máximo permitido

    // Verificar si se seleccionó un archivo
    if (inputFile.files.length > 0) {

        let selectedFile = inputFile.files[0];

        // Verificar el tipo de archivo (asegúrate de que sea una imagen)
        if (selectedFile.type.startsWith('image/')) {

            let img = new Image();

            // Leer el archivo como URL de datos
            fileReader.readAsDataURL(selectedFile);

            // Cuando se cargue la URL de datos
            fileReader.onload = (e) => {

                img.src = e.target.result;

                // Verificar las dimensiones de la imagen
                img.onload = () => {
                    console.log(img.width, img.height);
                    console.log(img.width > maxImageWidth, img.height > maxImageHeight);
                    if (img.width > maxImageWidth || img.height > maxImageHeight) {
                        // Mostrar mensaje de advertencia
                        alert('La imagen seleccionada es demasiado grande. Por favor, selecciona una imagen más pequeña.');
                        // Limpiar el input de archivo seleccionado
                        inputFile.value = '';
                    } else {

                        // let imageName = getImageName(selectedFile);
                        // let listImages = $("#list-images").val();

                        // if (listImages == "") {
                        //     $("#list-images").val(imageName);
                        // } else {
                        //     $("#list-images").val(listImages + "," + imageName);
                        // }

                        // La imagen es válida, mostrarla en el contenedor preview-image
                        let pImage = document.getElementById("preview-image");
                        let sImage = document.getElementById("show-image");
                        pImage.classList.remove("d-none");
                        sImage.classList.remove("d-none");
                        pImage.style.backgroundImage = `url(${e.target.result})`;
                        // pImage.style.width = img.width + 'px';
                        // pImage.style.height = img.height + 'px';
                    }
                };

            }
        } else {
            alert('El archivo seleccionado no es una imagen.');
            // Limpiar el input de archivo seleccionado
            inputFile.value = '';
        }
    }
}

/*Modal*/ 

// Obtener la imagen modal y el elemento modal
let modal = new bootstrap.Modal(document.getElementById('myModal'));
let modalImg = document.getElementById("modal-image");

// Mostramos la imagen de la vista previa en el modal
const showImage = () => {
    let image = document.getElementById("preview-image");
    modal.show();
    modalImg.src = image.style.backgroundImage.slice(4, -1).replace(/"/g, "");
}

const showPhoto = (btn) => {
    let image = document.getElementById("product_imagen");
    let model = btn.getAttribute("data-model");
    let id = btn.getAttribute("data-id");
    modalImg.src = `/uploads/${model}/${id}/${image.value}`;
    modal.show();
}

// Cuando el usuario haga clic en cualquier lugar fuera del modal, ciérrelo
window.onclick = function(event) {
  if (event.target === modal) {
    modal.hide();
  }
}

// Mostrar boton show-photo cuando se cambie la imagen
$("#product_imagen").change(function(e) {
    let btnShowPhoto = document.getElementById("show-photo");
    if (e.target.value === "") {
        btnShowPhoto.classList.add("d-none");
    } else {
        btnShowPhoto.classList.remove("d-none");
        btnShowPhoto.classList.add("d-block");
    }
});