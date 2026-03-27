const fs = require('fs');

// Read SQL files
const schema = fs.readFileSync('./schema.sql', 'utf-8');
const sampleData = fs.readFileSync('./sample_data.sql', 'utf-8');

// Execute schema
db.exec(schema, (err) => {
  if (err) console.error('Error creating tables:', err.message);
  else console.log('Tables created.');
});

// Execute sample data
db.exec(sampleData, (err) => {
  if (err) console.error('Error inserting data:', err.message);
  else console.log('Sample data inserted.');
});