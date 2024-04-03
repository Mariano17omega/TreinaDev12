let result = document.getElementById('result')
let planetInfo = document.getElementById('planetInfo')
let nextPageUrl = null;
let prevPageUrl = null; 

function redirectToPlanetDetails(planetUrl) { 
    const planetId = planetUrl.match(/planets\/(\d+)\//)[1];
    
    window.location.href = `planetDetails.html?id=${planetId}`;
}




async function printData(url = 'https://swapi.dev/api/planets/?page=1'){
    planets_list = await fetch(url);
    const data = await planets_list.json();
    nextPageUrl = data.next;
    prevPageUrl = data.previous;


    let planets = data.results;

    planets.forEach(planet => {
        let li = document.createElement('li');
        li.innerHTML = `
        <div> 
        <button class="planetButton" onclick="redirectToPlanetDetails('${planet.url}')">${planet.name}</button>
        </div>
        `
        result.appendChild(li); 
        
    document.getElementById('prevPageButton').style.display = prevPageUrl ? 'inline-block' : 'none';
    document.getElementById('nextPageButton').style.display = nextPageUrl ? 'inline-block' : 'none';

    });
}

 
async function fetchResidents(residentsUrls) {
    const tbody = document.querySelector('#residentsTable tbody'); 

    const residentsPromises = residentsUrls.map(url =>
        fetch(url).then(response => response.json())
    );

    const residents = await Promise.all(residentsPromises);

    residents.forEach(resident => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${resident.name}</td>
            <td>${resident.birth_year}</td>
        `;
        tbody.appendChild(tr);
    });
}


async function printDataPlanet(){
    const params = new URLSearchParams(window.location.search);
    const planetId = params.get('id');
  
    planetDetails = await fetch(`https://swapi.dev/api/planets/${planetId}`); 
    const planet = await planetDetails.json();
    let li = document.createElement('div');
    li.innerHTML = `
        <li>Clima: ${planet.climate}</li>
        <li>População: ${planet.population}</li>
        <li>Terreno: ${planet.terrain}</li>
    `
    planetInfo.appendChild(li); 
    fetchResidents(planet.residents);
}

async function searchPlanet() {
    const searchValue = document.getElementById('search').value;
    planetDetails = await fetch(`https://swapi.dev/api/planets/?search=${searchValue}`); 
    const planet = await planetDetails.json();
    redirectToPlanetDetails(planet.results[0].url)    
}
 

function loadNextPage() {
    result.innerHTML = ''; 
    printData(nextPageUrl);
}

function loadPrevPage() {
    if (prevPageUrl) {
        result.innerHTML = ''; 
        printData(prevPageUrl); 
    }
}

if (window.location.pathname.includes('index.html')) { 
    printData();
   
} else if (window.location.pathname.includes('planetDetails.html')) { 
    printDataPlanet();
}
