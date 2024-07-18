import { LightningElement } from 'lwc';
const DELAY=300;
export default class MovieSearch extends LightningElement {
    selectedType='';
    loading=false;
    selectedSearch='';
    selectedPageNo='1';
    delayTimeout;
    searchResult = [];
    selectedMovie='';
    get typeOptions() {
        return [
            { label: 'None', value: '' },
            { label: 'Movie', value: 'movie' },
            { label: 'Series', value: 'series' },
            { label: 'Episode', value: 'episode' },
        ];
    }

    handleChange(event){
        let{name, value} = event.target;
        this.loading=true;
        if(name === 'type'){
            this.selectedType = value;
        } else if(name === 'search'){
            this.selectedSearch = value;  
        } else if(name === 'pageno'){
            this.selectedPageNo = value;
        } 
        
        clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(()=>{
            this.searchMovie()
        }, DELAY);

    }

    async searchMovie(){
        const url = `https://www.omdbapi.com/?s=${this.selectedSearch}&type=${this.selectedType}&page=${this.selectedPageNo}&apikey=4a826b33`;
        const res = await fetch(url);
        const data = await res.json();
        console.log('Movie DATA: ', data);
        this.loading = false;
        if(data.Response === 'True'){
            this.searchResult = data.Search;
        }
    }

    get displayResult(){
        return this.searchResult.length > 0 ? true : false;
    }

    movieSelectedHandler(event){
        this.selectedMovie = event.detail;
    }


}