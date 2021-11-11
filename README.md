# Music-Detection-Lyrics-Generator-App
This is a mysic detection app that uses ShazamKit to detect music. Once it detects the music, it takes the information about that music to find lyrics for that song using a Lyrics API.

## Link for the lyrics API
https://lyricsovh.docs.apiary.io/#reference/0/lyrics-of-a-song/search?console=1

It is a very simple API to use. The format is https://api.lyrics.ovh/v1/artistName/songName. Once ShazamKit returns the metadata for a song, like artist name, title, subtitle, genre, etc., you can use the artist name and title of the song in the link to find lyrics for that song.

While this works well most of the time, there may be instances when there are multiple artists in a song and the lyrics are not found. Also, multiple artists that are added to the artist name using keywords like "and", "ft", "feat", etc, are not detected with this API. To get around this problem, I remove all these keywords and other artist name from the main artist name, and feed the API only the main artist name. This seems to work well with the few songs I have tested.

## Good source to follow along the code
https://developer.apple.com/documentation/shazamkit

https://rudrank.blog/experimenting-with-shazamkit

https://www.youtube.com/watch?v=QMO2cJNtn50

### Note
- This is not a completed project. It may have some errors or bugs.
- The lyrics API may not work well with lyrics in other languages (not English).

