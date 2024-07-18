import { LightningElement, api } from 'lwc';

export default class MovieTile extends LightningElement {
    @api movie;
    @api selectedMovieId;

    clickHandler(event){

        const evt = new customEvent ('selectedMovie', {
            detail : this.movie.imbdID
        })

        this.dispatchEvent(evt);
    }

    get tileSelected(){
        return this.selectedMovieId === this.movie.imdbID 
        ? 'tile selected' 
        : 'tile';
    }

}