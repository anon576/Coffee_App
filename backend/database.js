import mysql from 'mysql2'
import dotenv from 'dotenv'
dotenv.config()

const pool = mysql.createPool({
    host: process.env.HOST,
    user: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DATABASE
}).promise()

pool.getConnection()
    .then((connection) => {
        console.log('Database connected!');
        connection.release(); // Release the connection back to the pool
    })
    .catch((error) => {
        console.error('Error connecting to the database:', error.message);
    });




export async function checkUserExist(email) {
    try {

        const [user] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
        console.log(user)

        return {
            user:user,
            exist:user == undefined
        };
    } catch (error) {
        console.error('Error checking user existence:', error);
        throw error;
    }
}

export async function saveForgetPasswordOtp(email, otp) {
    try {
        // Insert forget password otp 
        const [user] = await pool.query(`UPDATE users SET otp = ${otp} WHERE email = ?`, [email]);
        const userId = user.insertId;

        // Retrieve and return the user by ID
        return getUserByID(userId);
    } catch (error) {
        console.error('Error inserting forget password otp:', error);
        throw error;
    }
}


export async function registerUser(name,lastname,mobileno,city , email) {
    try {

        const [user] = await pool.query('INSERT INTO users (name,lastname,mobile,city,email) VALUES (?, ?, ?, ?,?)', [name,lastname,mobileno,city, email]);

        const userId = user.insertId;

        // Retrieve and return the user by ID
        return userId;
    } catch (error) {
        console.error('Error registering user:', error);
        throw error;
    }
}

export async function updateUser(name, lasatname, mobileno, city, userid){
    await pool.query(
        `UPDATE users SET name=?, lastname=?, mobile=?, city=? WHERE userID = ?`,
        [name, lasatname, mobileno, city, userid]
    );

    return { success: true, message: "User Data Updated Successfully" };
}

export async function addBook(name,uid,price,status,description,author,image,category){
    const [book] = await pool.query("Insert into coffeeTable (bookname,author,price,status,uID,description,imagepath,category) Values(?,?,?,?,?,?,?,?)",[name,author,price,status,uid,description,image,category])

    const coffeeID = book.insertId

    return coffeeID
}

export async function updateBook(bid,bookname, userid, price, description, author, imagePath, category) {
    try {

        await pool.query(
            `UPDATE coffeeTable SET bookname=?, uID=?, price=?, description=?, author=?, imagepath=?, category=? WHERE bID = ?`,
            [bookname, userid, price, description, author, imagePath, category,bid]
        );

        return { success: true, message: "User Data Updated Successfully" };
    } catch (error) {
        console.error('Error updating user data:', error);
        throw error;
    }
}

export async function getUserBooks(userid){
    try {
        const [books] = await pool.query("SELECT * FROM coffeeTable WHERE uID = ?", [userid]);
        return books;
      } catch (error) {
        throw error;
      }
}

export async function deleteBook(bid){
    const [address] = await pool.query('DELETE FROM coffeeTable WHERE bID = ?', [bid]);

    return true
}

export async function getCount(){
    
    const len = await pool.query(`SELECT *
    FROM coffeeTable
    ORDER BY bID DESC
    LIMIT 1;`)

    return len[0][0]['bID']
}

export async function getTableLength(){
    const len = await pool.query(`SELECT COUNT(*) AS table_length
    FROM coffeeTable;
    `)

    return len[0][0]['table_length']
}


export async function fetctBooks(startId, endId){
    const query = `SELECT * FROM coffeeTable WHERE bID <= ? AND bID >= ? ORDER BY bID DESC`;
    const [books] = await pool.query(query, [startId, endId]);
    return books;
}


export async function addAddress(country,state,city,pin,near,userid){
    const [address] = await pool.query( 
        "Insert into address (country,state,city,location,uID,pin) Values(?,?,?,?,?,?)",[country,state,city,near,userid,pin]
    )

    const aid = address.insertId
    

    return aid
}


export async function updateAddress(aid,country, state, city, pin, near, userid) {
    try {

        await pool.query(
            `UPDATE address SET country=?, state=?, city=?, pin=?, location=?, uID=? WHERE aID = ?`,
            [country, state, city, pin, near, userid,aid]
        );

        return { success: true, message: "User Data Updated Successfully" };
    } catch (error) {
        console.error('Error updating user data:', error);
        throw error;
    }
}

export async function getAddress(userid){
    const [address] = await pool.query("select * from address where uID = (?)",[userid])
  

    return address
}

export async function deleteAddress(aid){
    const [address] = await pool.query('DELETE FROM address WHERE aID = ?', [aid]);

    return true
}

export async function placeOrder(coffeeID, aID, userID, paymentID, paymentStatus, status) {
    const [order] = await pool.query("INSERT INTO orders (coffeeID, addressID, userID, paymentID, paymentStatus, status) VALUES (?, ?, ?, ?, ?, ?)", [coffeeID, aID, userID, paymentID, paymentStatus, status]);
    
    return order.insertId;
}


export async function getUserOrders(userid) {
    try {
      const [orders] = await pool.query(`
        SELECT 
          coffeeTable.bookname,
          coffeeTable.author,
          coffeeTable.imagepath,
          coffeeTable.price,
          address.country,
          address.state,
          address.location,
          address.city,
          address.pin,
          orders.order_date,
          orders.paymentStatus,
          orders.paymentID,
          orders.status
        FROM 
          orders
        JOIN 
          coffeeTable ON orders.coffeeID = coffeeTable.bID
        JOIN 
          address ON orders.addressID = address.aID
        WHERE 
          orders.userID = ?`, [userid]);
  
      return orders;
    } catch (error) {
      throw error;
    }
  }
  

  export async function checkItemInCart(coffeeID, userid) {
    const [rows] = await pool.query("SELECT * FROM CartItems WHERE coffeeID = ? AND userID = ?", [coffeeID, userid]);
    return rows.length > 0; // If rows exist, return true; otherwise, return false
}

export async function addtocart(coffeeID,userid){
    const [cart] = await pool.query("INSERT INTO CartItems (coffeeID,userID) VALUES (?, ?)", [coffeeID, userid]);
    
    return cart.insertId;
}


export async function getCartItems(userid) {
    try {
        const [cartItems] = await pool.query(`
            SELECT CI.CartItemID, B.*, CI.userID
            FROM CartItems CI
            JOIN coffeeTable B ON CI.coffeeID = B.bID
            WHERE CI.userID = ?
        `, [userid]);

        return cartItems;
    } catch (error) {
        console.error("Error retrieving cart items:", error);
        throw error;
    }
}


export async function deleteItem(userid,coffeeID){
    const [item] = await pool.query('DELETE FROM CartItems WHERE userID = ? and coffeeID', [userid,coffeeID]);

    return true
}

