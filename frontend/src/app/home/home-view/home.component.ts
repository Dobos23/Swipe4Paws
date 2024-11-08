import { Component, ElementRef, ViewChild, viewChild, } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PetsListingComponent } from '../../pets-listing/pets-listing.component';
import { PetsListing } from '../../models/pets-listing';
import { MatSelectModule } from '@angular/material/select';
import { HomeService } from '../home.service';


@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, PetsListingComponent, MatSelectModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  petsListingList: PetsListing[] = [];
  showFilterOptions: boolean = false;
  nameFilter: string = '';
  typeFilter: string = '';
  genderFilter: string = '';
  sortOrder: string = '';

  constructor(private homeService: HomeService) {
    this.loadListData();
  }

  @ViewChild('dogVideo') dogVideo!: ElementRef<HTMLVideoElement>;
  @ViewChild('catVideo') catVideo!: ElementRef<HTMLVideoElement>;
  @ViewChild('otherVideo') otherVideo!: ElementRef<HTMLVideoElement>;
  @ViewChild('backgroundPic') backgroundPic!: ElementRef<HTMLPictureElement>;

  hideallVideos() {
    this.dogVideo.nativeElement.classList.remove('show');
    this.catVideo.nativeElement.classList.remove('show');
    this.otherVideo.nativeElement.classList.remove('show');
    this.backgroundPic.nativeElement.classList.add('show');

    this.dogVideo.nativeElement.pause();
    this.catVideo.nativeElement.pause();
    this.otherVideo.nativeElement.pause();
  }

  playVideo(animalButton: 'dog' | 'cat' | 'other') {
    this.hideallVideos();

    const video = {
      dog: this.dogVideo,
      cat: this.catVideo,
      other: this.otherVideo,
    }
    const selectedVideo = video[animalButton];

    selectedVideo.nativeElement.classList.add('show');
    selectedVideo.nativeElement.muted = true;
    selectedVideo.nativeElement.play();
  }

  pauseVideo(animal: 'dog' | 'cat' | 'other'): void {
    const videoMap = {
      dog: this.dogVideo,
      cat: this.catVideo,
      other: this.otherVideo,
    };

    const selectedVideo = videoMap[animal];
    selectedVideo.nativeElement.pause();
    selectedVideo.nativeElement.classList.remove('show');
    this.backgroundPic.nativeElement.classList.add('show');
  }

  

  /* FILTER METHODS */

  loadListData(){
    this.petsListingList = this.homeService.getList();
  }

  toggleFilterOptions() {
    this.showFilterOptions = !this.showFilterOptions;
  }


  applyFilters() {
    this.homeService.setFilters(this.nameFilter, this.typeFilter, this.genderFilter);
    this.loadListData();
  }

  resetFilters() {
    this.nameFilter = '';
    this.typeFilter = '';
    this.genderFilter = '';
    this.homeService.resetFilters();
    this.loadListData();

  }

  filterByType(type: string) {
    // this.homeService.filterByType(type);
    this.loadListData();
    this.typeFilter = type;
    this.applyFilters();
  }

  filterByGender(gender: string) {
    this.genderFilter = gender;
    this.applyFilters();
  }

  //Sorting
  sortBy(sortValue: string) {
    this.sortOrder = sortValue;
    if(this.sortOrder === "AZpets"){
      this.petsListingList.sort(function (a, b) {
        if (a.name < b.name) {
          return -1;
        }
        if (a.name > b.name) {
          return 1;
        }
        return 0;
      });
    }else if(this.sortOrder === "ZApets"){
      this.petsListingList.sort(function (a, b) {
        if (a.name < b.name) {
          return 1;
        }
        if (a.name > b.name) {
          return -1;
        }
        return 0;
      });
    }else if(this.sortOrder === "NewOldDate"){
      this.petsListingList.sort(function (a, b) {
        if (a.postDate < b.postDate) {
          return 1;
        }
        if (a.postDate > b.postDate) {
          return -1;
        }
        return 0;
      })

    }else if(this.sortOrder === "OldNewDate") {
      this.petsListingList.sort(function (a, b) {
        if (a.postDate < b.postDate) {
          return -1;
        }
        if (a.postDate > b.postDate) {
          return 1;
        }
        return 0;
      })
    }
    else if(this.sortOrder === "none"){
      this.loadListData();
    }
  }
}
