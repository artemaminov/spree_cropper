class Cropper {
    constructor() {
        this.croppers = [];
        this.collectData();
        if (this.croppers) {
            this.initTargets();
        }
    }

    collectData() {
        let dimensionsData = $('#source').data("dimensions");
        let cropperCoords = {};
        let cropper = {};
        let croppers = Object.keys(dimensionsData);
        for (let cropperName of croppers) {
            cropper = {};
            cropperCoords = {};
            cropper.id = cropperName;
            cropper.dimensions = dimensionsData[cropperName];
            cropper.name = cropper.dimensions.name;
            cropper.nameI18n = cropper.dimensions.name_i18n;
            cropperCoords.width = $(`#cropper_${cropperName}_width`).val();
            cropperCoords.height = $(`#cropper_${cropperName}_height`).val();
            cropperCoords.x = $(`#cropper_${cropperName}_x`).val();
            cropperCoords.y = $(`#cropper_${cropperName}_y`).val();
            cropper.coords = cropperCoords;
            this.croppers.push(cropper);
        }
    }

    initTargets() {
        // let croppers = document.getElementById('cropper-tabs-content');
        for (let cropper of this.croppers) {
            let newCropper = document.createElement('div');
            newCropper.setAttribute('id', `cropper-${cropper.id}`);
            // croppers.append(newCropper);
            this.addCropperTab(cropper, newCropper);
            this.canvasCopy(cropper);
            // this.initCrop(cropper);
            this.bindAutoFillInputs(cropper);
        }
    }

    canvasCopy(cropper) {
        let source = document.getElementById('source');
        let canvasContainer = document.getElementById(`cropper-${cropper.id}`);
        let canvas = source.cloneNode();
        canvas.id = `canvas-${cropper.id}`;
        canvasContainer.append(canvas);
    }

    initCrop(cropper) {
        let dimensions = cropper.dimensions;
        $(`#canvas-${cropper.id}`)
            .rcrop({
                minSize: [cropper.dimensions.width, cropper.dimensions.height],
                preserveAspectRatio: dimensions.preserveRatio,
                grid: true,
                inputs: true,
            })
            .on('rcrop-ready', event => this.applyData(cropper))
            .css('max-width', '100%');
    }

    bindAutoFillInputs(cropper) {
        $(`#canvas-${cropper.id}`).on('rcrop-changed rcrop-ready', event => this.fill(cropper));
    }

    fill(cropper) {
        let coords = this.getCoords(cropper);
        $(`#cropper_${ cropper.id }_x`).val(coords.x);
        $(`#cropper_${ cropper.id }_y`).val(coords.y);
        $(`#cropper_${ cropper.id }_width`).val(coords.width);
        $(`#cropper_${ cropper.id }_height`).val(coords.height);
        $(`#cropper_${ cropper.id }_dimension`).val(cropper.id);
    }

    applyData(cropper) {
        let dimensions = cropper.coords;
        $(`#canvas-${cropper.id}`).rcrop('resize', dimensions.width, dimensions.height, dimensions.x, dimensions.y);
    }

    getCoords(cropper) {
        let coords = $(`#canvas-${cropper.id}`).rcrop('getValues');
        return coords;
    }

    addCropperTab(cropper, cropperUI) {
        let newTab = document.createElement("li");
        newTab.setAttribute('role', 'presentation');

        let newTabLink = document.createElement("a");
        newTabLink.setAttribute('href', `#${cropper.name}`);
        newTabLink.setAttribute('aria-controls', `${cropper.name}`);
        newTabLink.setAttribute('role', "tab");
        newTabLink.setAttribute('data-toggle', "tab");
        newTabLink.textContent = cropper.nameI18n;

        let newTabPanel = document.createElement("div");
        newTabPanel.setAttribute('role', "tabpanel");
        newTabPanel.setAttribute('class', "tab-pane fade");
        newTabPanel.setAttribute('id', `${cropper.name}`);

        newTab.append(newTabLink);

        $(newTabLink).on('shown.bs.tab', event => this.initCrop(cropper));

        let croppersTabs = document.getElementById("croppers-tabs");
        croppersTabs.append(newTab);
        let croppersTabsContentPanel = document.getElementById("cropper-tabs-content");
        croppersTabsContentPanel.append(newTabPanel);
        newTabPanel.append(cropperUI);
    }

    static destroyAll() {
        $('#croppers-tabs li:first-child a').tab('show');
        let croppers = $('#cropper-tabs-content img');
        for (let cropper of croppers) {
            $(cropper).rcrop('destroy');
        }
    }
}

$(function() {
    window.cropper = new Cropper();
});
