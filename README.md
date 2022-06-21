# Project 1 - Flixter

Flixter is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [ ] User can tap a poster in the collection view to see a detail screen of that movie
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.

The following **additional** features are implemented:

- [ ] 

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would like to find a way to do the API call as a function so there wouldn't be as much rewrited code on the app.
2. Since we are passing the image we got from the API on both views (TableView and GridView), I would like to find the way to just write this code once, maybe by creating a class that works as a ImageView template as when we create templates for our Cells.


## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://user-images.githubusercontent.com/88735772/174415184-57ceac98-3f1f-45ef-9fa6-e6f48115e111.mov


## Notes

This was my first time using objective-c so it was very challenging to understand it's syntax. I've also had never developed any mobile apps so the process wasn't very intuitive procces for me. 

It took me a while to figure out how to do steps 4 and 7, and I also noticed I struggled to read objective-c's documentation so I need to get better at it. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2020] [Hugo Alejandro Gomez Herrera]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
