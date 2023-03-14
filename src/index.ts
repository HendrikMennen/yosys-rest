import express from "express";
import {execSync} from "child_process";

const app = express();

app.get('/', (req: any, res: any) => { 
    let t = execSync("yosys");
    res.send(t.toString());
});

app.listen(3000, () => { console.log('Server is up!') })