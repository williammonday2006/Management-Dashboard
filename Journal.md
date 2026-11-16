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

# Phase 3

I added a delete button that sends a DELETE request using the selected album's ID. After a successful response, the selection resets and a success message appears.

# Journal Prompt:

Checking the status code ensures the server successfully processed the request before the app tells the user the album was deleted.

# Phase 4

I tested fetching, selecting, and deleting albums. Everything worked as expected, and JSONPlaceholder successfully simulated deletion.

# Journal Prompt:

I verified that the album list loads, selecting albums updates the details, and deleting an album resets the selection. I also confirmed that the loading and error messages work correctly.