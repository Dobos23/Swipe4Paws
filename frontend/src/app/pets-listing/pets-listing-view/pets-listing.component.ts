import { CommonModule } from '@angular/common';
//Imports interfece PetsListing form pets-listing file.
import { PetsListing } from '../../models/pets-listing';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faHeart } from '@fortawesome/free-solid-svg-icons';
import {
  ChangeDetectionStrategy,
  Component,
  Input,
  OnInit,
} from '@angular/core';
import { FavouritesService } from '../../favourites/favourites.service';
import { FavoriteModel } from '../../models/FavoriteModel';
import { AuthService } from '../../../auth/auth.service';
import {
  Router,
  RouterConfigOptions,
  RouteReuseStrategy,
} from '@angular/router';

@Component({
  selector: 'app-pets-listing',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  //link to html file
  templateUrl: './pets-listing.html',
  //link to css file
  styleUrl: './pets-listing.component.css',
})
export class PetsListingComponent implements OnInit {
  @Input() petsListing!: PetsListing;
  @Input() favourites: FavoriteModel[] = [];
  faHeart = faHeart;
  isLiked = false;
  userid!: number;

  constructor(
    private favouritesService: FavouritesService,
    private auth: AuthService,
    private router: Router
  ) {
    this.auth.getTokenPayload().subscribe({
      next: (token) => {
        this.userid = token.userid;
      },
      error: (error) => {
        console.log('not logged in', error);
      },
    });
  }

  getBehaviorString(): string {
    return this.petsListing.behaviors.map((b) => b.behavior).join(', ');
  }

  isLoggedIn(): boolean {
    return this.auth.isLoggedIn();
  }

  ngOnInit(): void {
    // Checking if the pet is favourited
    this.favourites.forEach((favourite) => {
      if (favourite.petid === this.petsListing.petid) {
        this.isLiked = true;
      }
    });

    // Loading userid for add/delete favourite operations
    this.auth.getId().subscribe((id) => {
      this.userid = id;
      console.log(`Loaded userid ${this.userid}`);
    });
  }

  toggleLike() {
    if (!this.isLoggedIn()) {
      alert('You are not logged in');
      return;
    }
    this.isLiked = !this.isLiked;
    if (this.isLiked) {
      this.favouritesService
        .addFavourite(this.petsListing.petid, this.userid)
        .subscribe({
          next: (response) => {
            console.log('Favourite added:', response);
          },
          error: (error) => {
            console.error('Error adding favourite:', error);
          },
        });
    } else {
      this.favouritesService
        .deleteFavourite(this.petsListing.petid, this.userid)
        .subscribe({
          next: (response) => {
            console.log('Favourite removed:', response);
          },
          error: (error) => {
            console.error('Error adding favourite:', error);
          },
        });
    }
  }

  redirectToPetDetails(petid: number) {
    console.log('Redirecting to pet details:', petid);
    this.router.navigateByUrl(`petInfo/${petid}`);
  }
}
