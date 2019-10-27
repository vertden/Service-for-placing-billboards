
// Initialize and add the map
function initMap() {
    // The location of Minsk
    var minsk = {lat: 53.902171, lng: 27.555031};
    // The map, centered at Minsk
    var map = new google.maps.Map(
        document.getElementById('map'), {zoom: 11, center: minsk});

}
