import { HttpClient } from '@angular/common/http'; 
import { Component, OnInit } from '@angular/core'; 
import { environment } from 'src/environments/environment'; 
import { team } from 'hackthefuture'; 
import { share, Subject, switchMap, takeUntil, timer } from 'rxjs'; 
import { ApiService } from './api.service'; @Component({ selector: 'app-root', templateUrl: './app.component.html', styleUrls: ['./app.component.css'] })


export class AppComponent implements OnInit {
        title = 'app'; challengeResults: any; challengeService: any; points: number; showNext: boolean = !1; private stopPolling = new Subject(); constructor(private http: HttpClient, private apiService: ApiService) { console.log("You found a BONUS: ARXUSGOESSKIING") }
    ngOnInit(): void {
        this.http.post<number[]>(`${environment.apiUrl}/static-website?code=${team.teamId}&clientId=${team.teamId}`, null, { headers: { 'x-team-id': team.teamId } }).subscribe()
        timer(1, 3000).pipe(switchMap(() => { return this.apiService.getChallengesStatuses() }), share(), takeUntil(this.stopPolling)).subscribe((result: any) => { if (result && result.length > 0 && result.find(r => r.id === "2")) { this.showNext = !0 } })
    }
    ngOnDestroy() { this.stopPolling.next("stop") }
}
