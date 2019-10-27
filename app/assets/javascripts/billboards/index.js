
// Initialize and add the map
function initMap() {
    // The location of Minsk
    var minsk = {lat: 53.902171, lng: 27.555031};
    // The map, centered at Minsk
    var map = new google.maps.Map(
        document.getElementById('map'), {zoom: 11, center: minsk});
    // The markers, positioned at Minsk
    var bil1 = {lat: 53.901797, lng: 27.548709};
    var marker1 = new google.maps.Marker({position: bil1, map: map});
    var bil2 ={lat: 53.908984, lng: 27.494670}
    var marker2 = new google.maps.Marker({position: bil2, map: map});
}
