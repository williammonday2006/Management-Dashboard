# Phase 0

I will create an Album model, fetch albums from the API, and display them in a list. Users will be able to select an album to view its details or delete it.

# Journal Prompt:
I'm most confused about how the app communicates with the server and updates the screen when an album is selected or deleted.

# Phase 1

I created an Album model and connected the app to the JSONPlaceholder API. The albums are displayed using a ListView.builder, while FutureBuilder handles loading, success, and error states.

# Journal Prompt:

When requesting multiple items, I receive a list of albums instead of just one album, so I need to convert each JSON object into an Album.

# Phase 2

I added album selection using a state variable. Clicking an album displays its title, ID, and User ID above the list.

# Journal Prompt:

Using a state variable updates part of the current screen instead of navigating to an entirely new page.