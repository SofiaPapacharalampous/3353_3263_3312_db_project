const mysql = require('mysql');

// Connection Pool
const pool = mysql.createPool({
    connectionLimit : 100, 
    host            : process.env.DB_HOST,
    user            : process.env.DB_USER,
    password        : process.env.DB_PASS,
    database        : process.env.DB_NAME
});

const allColors = {
    Pink: {
        light: "#98abc5",
        dark: "#98abc5"
    },
    Orange: {
        light: "#6b486b",
        dark: "#6b486b"
    },
    Blue: {
        light: "#a05d56",
        dark: "#a05d56"
    },
    Green: {
        light: "#d0743c",
        dark: "#d0743c"
    },
    Red: {
        light: "#ff8c00",
        dark: "#ff8c00"
    }  
};
/* Not anymore, just to match with observable */
const listOfColors = ["Pink", "Orange", "Blue", "Green", "Red"];

const measures = {
    anemia: {
        year: "Y_ID_Anm", 
        country: "C_ID_Anm",
        measure: "Prevalence_Percentage_U5"
    },
    child_mortality: {
        year: "Y_ID_ChM", 
        country: "C_ID_ChM",
        measure: "Child_Mortality_Percentage_U5"
    },
    gdp: {
        year: "Y_ID_GDP", 
        country: "C_ID_GDP",
        measure: "Total_Yearly_Growth"
    },
    hapiscore: {
        year: "Y_ID_HS", 
        country: "C_ID_HS",
        measure: "WHR"
    },
    hdi: {
        year: "Y_ID_HDI", 
        country: "C_ID_HDI",
        measure: "HDI_Score"
    },
    kcal: {
        year: "Y_ID_KCal", 
        country: "C_ID_KCal",
        measure: "Per_person_daily"
    },
    malnutrition: {
        year: "Y_ID_MalNutr", 
        country: "C_ID_MalNutr",
        measure: "Weight_For_Age_Percent_U5"
    },
    overweight: {
        year: "Y_ID_OW", 
        country: "C_ID_OW",
        measure: "Prevalence_Percentage_U5"
    },
    severe_wasting: {
        year: "Y_ID_SW", 
        country: "C_ID_SW",
        measure: "Prevalence_Percentage_U5"
    },
    stunting: {
        year: "Y_ID_Stunt", 
        country: "C_ID_Stunt",
        measure: "Prevalence_Percentage_U5"
    },
    sugar_consumption: {
        year: "Y_ID_SC", 
        country: "C_ID_SC",
        measure: "Grams_Per_Person_Daily"
    },
    undernourishment: {
        year: "Y_ID_UNour", 
        country: "C_ID_UNour",
        measure: "Prevalence_Percentage_Populationt"
    },
    underweight: {
        year: "Y_ID_UW", 
        country: "C_ID_UW",
        measure: "Prevalence_Percentage_U5"
    }
};

const spans = {
    one: ["Year_Descr","",""],
    five: ["FiveYSpan","AVG(",")"],
    ten: ["Decade","AVG(",")"]
};

const indexesFormalNames = {
    anemia: "Anemia",
    child_mortality: "Child Mortality",
    gdp: "GDP",
    hapiscore: "Hapiscore",
    hdi: "HDI",
    kcal: "KCal",
    malnutrition: "Malnutrition",
    overweight: "Overweight",
    severe_wasting: "Severe Wasting",
    stunting: "Stunting",
    sugar_consumption: "Sugar Consumption",
    undernourishment: "Undernourishment",
    underweight: "Underweight",
}

var csig = false;
var isig = false;
var ssig = false;
var nodata = false;

function makeQuery(countries, indexes, span, isTimeline, isScatterplt) {
    var ctr = "C_CodeName";
    if(isTimeline) {
        ctr = "C_Name"
    }
    var op = "OR";
    if(isScatterplt) {
        op = "AND";
    }
    var query = "SELECT ";
    //if(span === "one") { // Yearly
    query += `years.${spans[span][0]} as year, countries.C_Name as country`
      for (let i in indexes) {
        if(isScatterplt) {
            query += `, ${spans[span][1]}${indexes[i]}.${measures[indexes[i]].measure}${spans[span][2]} as '${indexesFormalNames[indexes[i]]}'`
        } else {
            query += `, ${spans[span][1]}${indexes[i]}.${measures[indexes[i]].measure}${spans[span][2]} as '${indexes[i]}'`
        }
          
      }
      query += `
FROM  (countries, years)` 
      for (let i in indexes) {
        query += `
LEFT JOIN ${indexes[i]} ON ${indexes[i]}.${measures[indexes[i]].year} = years.Y_ID AND ${indexes[i]}.${measures[indexes[i]].country} = countries.C_ID`;
      }
      query += `
WHERE ( `;
      for(let i in countries) {
        if(i < countries.length - 1) {
          query += `countries.${ctr} = '${countries[i]}' OR `;
        } else {
          query += `countries.${ctr} = '${countries[i]}' ) AND ( `;
        }
      }
      for(let i in indexes) {
        if(i < indexes.length - 1) {
          query += `${indexes[i]}.${measures[indexes[i]].measure} IS NOT NULL ${op} `
        } else {
          query += `${indexes[i]}.${measures[indexes[i]].measure} IS NOT NULL )`
        }
      }
      if(span !== "one") {
        query += `
GROUP BY years.${spans[span][0]}, countries.C_ID`;
      }
      query += `
ORDER BY year`;
    console.log(query);
    return query;
}

exports.home = (req, res) => {
    res.render('home');
}

exports.renderTLOptions = (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) {
            console.log('Error occured! :( ');
            throw err;
        } else {
            var query = `SELECT countries.C_Name as country
                         FROM countries`
            connection.query(query, (err, rows) => {
                connection.release();
                if(!err) {
                    var rend = { rows };
                    if(csig) {
                        rend.csig = true;
                        csig = false;
                    }
                    if(isig) {
                        rend.isig = true;
                        isig = false;
                    }
                    if(ssig) {
                        rend.ssig = true;
                        ssig = false;
                    }
                    if(nodata) {
                        rend.nodata = true;
                        nodata = false;
                    }
                    
                    res.render('tl_options', rend);
                } else {
                    console.log(err)
                    res.json("Something went wrong");
                }
            });
        }
    });
}

exports.timeline = (req, res) => {
    //console.log('Body: ', req.body); // typwnei ena struct mono me ta checked antikeimena, px an epilexoyme ta options 1 kai 2
                                        // tote req.body = { box1: '1', box2: '1' }
    var countries = []
    var indexes = []
    var span = '';
    for (let opt in req.body) {
        var type = opt.split(" ")[0];
        var name = opt.split(" ")[1];
        if( type === "c") {
            countries.push(opt.split(" ").slice(-(opt.split(" ").length-1)).join(' '));
        } else if( type === "i") {
            indexes.push(name)
        } else if( type === "y") {
            span = name;
        }
    }
    //console.log("countries: ", countries);
    //console.log("indexes: ", indexes);
    if(countries.length === 0 || indexes.length === 0 || span === '') {
        if(countries.length === 0) { csig = true; }
        if(indexes.length === 0) { isig = true; }
        if(span === '') { ssig = true; }
        res.redirect('/timeline-options');              
    } else {
        var query = makeQuery(countries, indexes, span, true, false);
        pool.getConnection((err, connection) => {
            if(err) {
                console.log('Error occured! :( ');
                throw err;
            }
            connection.query(query, (err, rows) => {
                connection.release();
                if(!err) { 
                    if(rows.length === 0) {
                        nodata = true;
                        res.redirect('/timeline-options');
                    } else {
                        var data = [];
                        var dt = {}; 
                        dt.Date = rows[0].year.toString();
                        prevyear = rows[0].year;
                        for(let r in rows) {
                            if(rows[r].year != prevyear) {
                                data.push(dt);
                                dt = {};
                                dt.Date = rows[r].year.toString();
                                prevyear = rows[r].year;
                            }
                            for(let i in indexes) {
                                line = indexes[i] + " " + rows[r].country;
                                if(rows[r][indexes[i]] === null) {
                                    dt[line] = NaN;
                                } else {
                                    dt[line] = rows[r][indexes[i]];
                                }
                            }
                        }
                        data.push(dt);
                        var colors = {};
                        for(let c in countries) {
                            for(let i in indexes) {
                                line = indexes[i] + " " + countries[c];
                                colors[line] = allColors[listOfColors[c]];
                            }
                        }
                        var indxs = {};
                        var bools = [true, false];
                        for (let i in indexes) {
                            indxs[indexes[i]] = bools[i];
                        }
                        var clrs = JSON.stringify(colors);
                        var fruits = JSON.stringify(data);
                        var isDashed = JSON.stringify(indxs);
                        var s = {
                            span: span
                        }
                        var s = JSON.stringify(s);
                        var names = JSON.stringify(indexesFormalNames);

                        res.render('timeline', { fruits, clrs, isDashed, s, names});
                    }
                } else {
                    console.log(err);
                }
            });
        });
    }
}

exports.renderBCOptions = (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) {
            console.log('Error occured! :( ');
            throw err;
        } else {
            var query = `SELECT countries.C_Name as country
                         FROM countries`
            connection.query(query, (err, rows) => {
                connection.release();
                if(!err) {
                    for(let country in rows) {
                        rows[country].countryName = rows[country].country;
                        rows[country].country = rows[country].country.replaceAll(" ", "");
                        rows[country].country = rows[country].country.replaceAll(",", "");
                        rows[country].country = rows[country].country.replaceAll(".", "");
                        rows[country].country = rows[country].country.replaceAll("'", "");
                    }
                    var countries = JSON.stringify(rows);
                    var rend = { rows, countries };

                    if(csig) {
                        rend.csig = true;
                        csig = false;
                    }
                    if(isig) {
                        rend.isig = true;
                        isig = false;
                    }
                    if(ssig) {
                        rend.ssig = true;
                        ssig = false;
                    }
                    if(nodata) {
                        rend.nodata = true;
                        nodata = false;
                    }
                    //console.log(rend)
                    res.render('bc_options', rend);
                } else {
                    console.log(err)
                    res.json("Something went wrong");
                }
            });
        }
    }); 
}

exports.barchart = (req, res) => {
    //console.log('Body: ', req.body);
    var country = '';
    var indexes = [];
    var span = '';
    for (let opt in req.body) {
        var type = opt.split(" ")[0];
        var name = opt.split(" ")[1];
        if( type === "c") {
            country = opt.split(" ").slice(-(opt.split(" ").length-1)).join(' ');
        } else if( type === "i") {
            indexes.push(name)
        } else if( type === "y") {
            span = name;
        } 
    }

    if(country === '' || indexes.length === 0 || span === '') {
        if(country === '') { csig = true; }
        if(indexes.length === 0) { isig = true; }
        if(span === '') { ssig = true; }
        res.redirect('/barchart-options');
                    
    } else {
        var query = makeQuery([country], indexes, span, false, false);

        pool.getConnection((err, connection) => {
            if(err) {
                console.log('Error occured! :( ');
                throw err;
            }
            connection.query(query, (err, rows) => {
                connection.release();
                if(!err) {      
                    if(rows.length === 0) {
                        nodata = true;
                        res.redirect('/barchart-options');
                    } else {
                        //console.log("Number of rows: ", rows.length);
                        var data = [];
                        for(let i in rows) {
                            var c = 0;
                            var dt = {};
                            dt.year = rows[i].year
                            for(let column in rows[i]) {
                                if(column !== "year" && column !== "country") {
                                    if(rows[i][column] === null) {
                                        dt[`${column}-${rows[i].country}`] = undefined;
                                    } else {
                                        dt[`${column}-${rows[i].country}`] = rows[i][column];
                                        //if(rows[i][column] !== 0) {
                                        c=c+1;
                                        //}
                                    }
                                }
                            }
                            if(c > 0) {
                                data.push(dt);
                            }
                        }
                        var columns = [];
                        for(let c in data[0]) {
                            columns.push(c);
                        }
                        var data = JSON.stringify(data);
                        var columns = JSON.stringify(columns);
                        var names = JSON.stringify(indexesFormalNames);
                        res.render('barchart', {data, columns, names});
                    }
                } else {
                    console.log(err);
                }
            });
        });    
    }
}

exports.renderSPOptions = (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) {
            console.log('Error occured! :( ');
            throw err;
        } else {
            var query = `SELECT countries.C_Name as country
                         FROM countries`
            connection.query(query, (err, rows) => {
                connection.release();
                if(!err) {
                    for(let country in rows) {
                        rows[country].countryName = rows[country].country;
                        rows[country].country = rows[country].country.replaceAll(" ", "");
                        rows[country].country = rows[country].country.replaceAll(",", "");
                        rows[country].country = rows[country].country.replaceAll(".", "");
                        rows[country].country = rows[country].country.replaceAll("'", "");
                    }
                    var countries = JSON.stringify(rows);

                    var rend = { rows, countries };
                    if(csig) {
                        rend.csig = true;
                        csig = false;
                    }
                    if(isig) {
                        rend.isig = true;
                        isig = false;
                    }
                    if(ssig) {
                        rend.ssig = true;
                        ssig = false;
                    }
                    if(nodata) {
                        rend.nodata = true;
                        nodata = false;
                    }
                    res.render('sp_options', rend);
                } else {
                    console.log(err)
                    res.json("Something went wrong");
                }
            });
        }
    }); 
}

exports.scatterplot = (req, res) => {
    //console.log('Body: ', req.body);
    var country = '';
    var indexes = [];
    var span = '';
    for (let opt in req.body) {
        var type = opt.split(" ")[0];
        var name = opt.split(" ")[1];
        if( type === "c") {
            country = opt.split(" ").slice(-(opt.split(" ").length-1)).join(' ');
        } else if( type === "i") {
            indexes.push(name)
        } else if( type === "y") {
            span = name;
        } 
    }

    if(country === '' || indexes.length < 2 || span === '') {
        if(country === '') { csig = true; }
        if(indexes.length < 2) { isig = true; }
        if(span === '') { ssig = true; }
        res.redirect('/scatterplot-options');           
    } else {
        var query = makeQuery([country], indexes, span, false, true);

        pool.getConnection((err, connection) => {
            if(err) {
                console.log('Error occured! :( ');
                throw err;
            }
            connection.query(query, (err, rows) => {
                connection.release();
                if(!err) {
                    if(rows.length === 0) {
                        nodata = true;
                        res.redirect('/scatterplot-options');
                    } else {
                        var data = [];
                        var x = indexesFormalNames[indexes[0]];
                        var y = indexesFormalNames[indexes[1]];
                        
                        for(let i in rows) {

                            data.push({
                                category: rows[i].country,
                                x: rows[i][x],
                                y: rows[i][y]
                            });
                        }
                        var data = JSON.stringify(data);
                        var x = {
                            x:x
                        };
                        x = JSON.stringify(x);
                        var y = {
                            y:y
                        };
                        y = JSON.stringify(y);

                        res.render('scatterplot', {data, x, y});
                    }

                } else {
                    console.log(err);
                }
            });
        });
    }
}
