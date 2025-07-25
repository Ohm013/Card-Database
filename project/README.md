# cs_340 db
GROUP 65 Ohm Patel and Sienna Raigoza


## References 

### Citation for the Stored Procedure: located in database file.

**sp_CreateCard.sql** 
- Date: 5/20/2025
- scope: SP for INSERT logic
- Originality: Adapted from CREATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_CreateCustomer.sql** 
- Date: 5/20/2025
- scope: SP for INSERT logic
- Originality: Adapted from CREATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_CreateOrder.sql** 
- Date: 5/30/2025
- scope: SP for INSERT logic
- Originality: Adapted from CREATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_CreateSet.sql** 
- Date: 5/29/2025
- scope: SP for INSERT logic
- Originality: Adapted from CREATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_DeleteCard.sql** 
- Date: 5/29/2025
- scope: SP for DELETE logic
- Originality: Adapted from DELETE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_DeleteCustomer.sql**
- Date: 5/20/2025
- scope: SP for DELETE logic
- Originality: Adapted from DELETE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_DeleteOrder.sql** 
- Date: 5/20/2025
- scope: SP for DELETE logic
- Originality: Adapted from DELETE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_reset_db.sql**
- Date: 5/20/2025
- scope: Wrapper for Pl/SQL
- Originality: Adapted from CREATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_UpdateCard.sql**
- Date: 5/29/2025
- scope: SP for UPDATE logic
- Originality: Adapted from UPDATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_UpdateCustomer.sql** 
- Date: 5/20/2025
- scope: SP for UPDATE logic
- Originality: Adapted from UPDATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_UpdateOrder.sql**
- Date: 5/30/2025
- scope: SP for UPDATE logic
- Originality: Adapted from UPDATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_UpdateOrder.sql**
- Date: 6/1/2025
- scope: SP for orders table when recalculating quantity from join table
- Originality: Adapted with AI, to fix and troubleshoot logic 
- Summary of prompts: Using the following schema on MariaDB for Pokémon database DB [copy and paste the entire DDL for DDL.sql here], can you help me figure out why when I update an order in the sp_updateOrder.sql [copy and paste the entire DDL for DDL.sql here] why the quantity won't update when I update a card for an order that has multiple cards in it? 
- I needed to find the total quantity using SUM() for all the orders_cards entries and use a subquery to update it in orders.
- Source URL:  https://chat.openai.com

**sp_UpdateOrderCard.sql** 
- Date: 5/31/2025
- scope: SP for UPDATE logic
- Originality: Adapted from UPDATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**sp_UpdateSet.sql** 
- Date: 5/29/2025
- scope: SP for UPDATE logic
- Originality: Adapted from UPDATE Stored procedure on exploration page
- Exploration - Implementing CUD operations in your app
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

**Adapted from:**

**Source URL:** https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968


## Citation for the backend
**db-connector.js**
- Date: 5/07/2025
- scope: My SQL connection
- Originality: Adapted from starter code Build db-connector.js
- Exploration - Web Application Technology
- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948 


## Citation for the following handlebars
**files:**
- main.hbs
- customers.hbs
- home.hbs
- orders_cards.hbs
- orders.hbs
- pokemon_cards.hbs
- sets.hbs

**Date:** 
5/07/2025

**Scope:** 
frontend views using handlebars Templating


**Originality:** Adapted from starter code Building our webpage with Handlebars Templating Engine.
Exploration - Web Application Technology

**Source URL:** https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948 

## Citation for app.js
**app.js**

**Date:** 
5/07/2025

**Scope:** routing logic, showing the views of the handlebars, queries.

**Originality:** Adapted from starter code Build app.js.
Exploration - Web Application Technology

**Originality:** Adapted from starter code for CUD ROUTES
Exploration - Implementing CUD operations in your app

**Source URL:** https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948 
https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968



### Citation for the helper function in app,js
**file:** app.js

**Date:** 5/31/2025

**Scope:** Helper function to format the SQL DATE values 

**Originality:** Adapted with AI help

**Summary of prompt:**
I asked how to format my app.js to have my DATE in my sql files show as a string without so much information just for example “Fri Nov 08 2024”,  and it suggest to add a helper function in the '.hbs', engine. and use `Date` and `toDateString()`

**AI Source URL:** https://chat.openai.com 
