use regex::Regex;
use std::fs::File;
use std::io::{self, BufRead};

fn main() -> io::Result<()> {
    let input_file = "input.txt";
    let pattern = r"mul\((\d{1,3}),(\d{1,3})\)";
    let pattern_do = r"do\(\)";
    let pattern_dont = r"don't\(\)";
    let pattern_comb = r"mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)";
    let re = Regex::new(pattern).expect("Invalid");
    let re_comb = Regex::new(pattern_comb).expect("Invalid");

    let file = File::open(&input_file)?;
    let reader = io::BufReader::new(file);

    let mut muls: Vec<(i32, i32)> = Vec::new();

    let mut enabled = true;
    for line in reader.lines() {
        let line = line?;
        // swap re_comb for re for P1
        for cap in re_comb.captures_iter(&line) {
            if let Some(matched) = cap.get(0) {
                let matched_str = matched.as_str();
                if matched_str.starts_with("do(") {
                    println!("DOOO");
                    enabled = true;
                } else if matched_str.starts_with("don't") {
                    println!("DONNNNNTTT");
                    enabled = false;
                } else if matched_str.starts_with("mul") && enabled == true {
                    let x: i32 = cap[1].parse().expect("x failed");
                    let y: i32 = cap[2].parse().expect("y failed");
                    println!("muls {}, {}", x, y);
                    muls.push((x, y));
                }
            }
        }
    }
    println!("Result {}", muls.iter().map(|&(x, y)| x * y).sum::<i32>());

    Ok(())
}
