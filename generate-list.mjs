import fs from 'fs';
import path from 'path';

const directoryPath = path.join(process.cwd(), 'images/weekly-groceries');
const outputFilePath = path.join(process.cwd(), 'groceries.json');

try {
    const files = fs.readdirSync(directoryPath);

    // Filter out any non-image files or system files like .DS_Store
    const imageFiles = files.filter(file => 
        /\.(jpe?g|png|gif|webp)$/i.test(file)
    );

    // Convert the array to a nicely formatted JSON string
    const jsonContent = JSON.stringify(imageFiles, null, 4);

    fs.writeFileSync(outputFilePath, jsonContent);

    console.log(`✅ Successfully generated groceries.json with ${imageFiles.length} items.`);

} catch (err) {
    console.error('❌ Error generating file list:', err);
}