import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';


const initMapbox = () => {
  
  const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this
      
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
  };
  
  const fitMapToMarkers = (map, markers) => {
    if (markers.length == 0) return
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 22, duration: 0 });
  };
  
  const mapElement = document.querySelector('#map');
  
  if (mapElement) {
    const markers = JSON.parse(mapElement.dataset.markers);
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    // console.log(typeof mapElement.dataset.center)
    const center = JSON.parse(mapElement.dataset.center)

    if (mapElement.dataset.center !== 'null') {
      console.log(mapElement.dataset.center);
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [center[1], center[0]],
        zoom: 16
      });

    addMarkersToMap(map, markers);

    fitMapToMarkers(map, markers);

    } else {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11'
      });

      addMarkersToMap(map, markers);

      fitMapToMarkers(map, markers);
    }
  }
};

export { initMapbox };
