
    // #Citation for the following code:
    // # Date: 5/07/2025
    // # scope: My SQL connection
    // # Originality: Adapted from starter code Build db-connector.js
    //   Exploration - Web Application Technology
    // # Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948 --}}
  
// Get an instance of mysql we can use in the app
let mysql = require('mysql2')

// Create a 'connection pool' using the provided credentials
const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : 10,
    host              : 'classmysql.engr.oregonstate.edu',
    user              : '',
    password          : '',
    database          : 'cs340_raigozas',
    multipleStatements: true
}).promise(); // This makes it so we can use async / await rather than callbacks

// Export it for use in our application
module.exports = pool;