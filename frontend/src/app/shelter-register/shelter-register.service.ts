import { Injectable } from '@angular/core';
import { SheltersListing } from '../models/shelters-listing';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../auth/auth.service';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class ShelterRegisterService {
  private auth: AuthService;
  constructor(private http: HttpClient, private router: Router) {
    this.auth = new AuthService(this.http, this.router);
  }

  async createShelter(shelter: SheltersListing): Promise<any> {
    this.http
      .post<{ token: string }>(
        'http://localhost:3000/shelters/register',
        shelter
      )
      .subscribe({
        next: (response) => {
          console.log(response);
          //save in browser storage
          if(response.token === "Shelter not approved") {
            alert('An admin will look at your shelter to guarantee its authenticity. You will be contacted soon.');
            return;
          } else if(response.token === "Shelter rejected") {
            alert('Shelter rejected. Please contact admin.');
            return;
          }
          localStorage.setItem('token', response.token);
          this.auth.getUserRole();
        },
        error: (error) => {
          console.error(error);
          return error;
        },
      });
  }
}
