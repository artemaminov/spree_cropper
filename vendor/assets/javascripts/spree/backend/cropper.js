class Cropper {
    constructor() {
        this.croppers = [];
        this.collectData();
        this.initTargets();
    }

    collectData() {
        let dimensionsData = $('#source').data("dimensions");
        let cropperCoords = {};
        let cropper = {};
        let croppersNames = Object.keys(dimensionsData);
        for (let cropperName of croppersNames) {
            cropper = {};
            cropperCoords = {};
            cropper.name = cropperName;
            cropper.dimensions = dimensionsData[cropperName];
            cropperCoords.width = $(`#${cropperName}_cropper_width`).val();
            cropperCoords.height = $(`#${cropperName}_cropper_height`).val();
            cropperCoords.x = $(`#${cropperName}_cropper_x`).val();
            cropperCoords.y = $(`#${cropperName}_cropper_y`).val();
            cropper.coords = cropperCoords;
            this.croppers.push(cropper);
        }
    }

    initTargets() {
        for (let cropper of this.croppers) {
            $('#croppers').append(`<div id="cropper-${cropper.name}"></div>`);
            this.addTargetHeader(cropper);
            this.canvasCopy(cropper);
            this.initCrop(cropper);
            this.bindAutoFillInputs(cropper);
        }
    }

    addTargetHeader(cropper) {
        let canvasesContainer = document.getElementById(`cropper-${cropper.name}`);
        $(`<span>${cropper.name}</span>`).appendTo(canvasesContainer);
    }

    canvasCopy(cropper) {
        let source = document.getElementById(`source`);
        let canvasesContainer = document.getElementById(`cropper-${cropper.name}`);
        let canvas = source.cloneNode();
        canvas.id = `${cropper.name}-canvas`;
        canvasesContainer.appendChild(canvas);
    }

    initCrop(cropper) {
        $('#previews').append(`<div id="preview-${cropper.name}"></div>`);
        let dimensions = cropper.dimensions;
        $(`#${cropper.name}-canvas`)
            .rcrop({
                minSize: [dimensions.width, dimensions.height],
                // preserveAspectRatio: true,
                grid: true,
                inputs: true,
                // preview: {
                //     display: true,
                //     size: [dimensions.width, dimensions.height],
                //     wrapper: `#preview-${target.name}`,
                // }
            })
            .on('rcrop-ready', event => this.applyData(event, cropper));
    }

    bindAutoFillInputs(cropper) {
        $(`#${cropper.name}-canvas`).on('rcrop-changed rcrop-ready', event => this.fill(event, cropper));
    }

    fill(event, cropper) {
        let coords = this.getCoords(cropper);
        $(`#${ cropper.name }_cropper_x`).val(coords.x);
        $(`#${ cropper.name }_cropper_y`).val(coords.y);
        $(`#${ cropper.name }_cropper_width`).val(coords.width);
        $(`#${ cropper.name }_cropper_height`).val(coords.height);
    }

    applyData(event, cropper) {
        let dimensions = cropper.coords;
        $(`#${cropper.name}-canvas`).rcrop('resize', dimensions.width, dimensions.height, dimensions.x, dimensions.y);
    }

    getCoords(cropper) {
        let coords = $(`#${cropper.name}-canvas`).rcrop('getValues');
        return coords;
    }
}

$(function() {
    new Cropper();
});
