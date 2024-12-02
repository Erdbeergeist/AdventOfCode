use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn main() -> io::Result<()> {
    let input_file = "input.txt";

    let mut input: Vec<Vec<i32>> = Vec::new();
    let file = File::open(&input_file)?;
    let reader = io::BufReader::new(file);

    for line in reader.lines() {
        let line = line?;

        let numbers: Vec<i32> = line
            .split_whitespace()
            .map(|num| num.parse::<i32>().unwrap())
            .collect();

        input.push(numbers);
    }

    let mut safe_vec: Vec<i32> = Vec::new();

    // I understand that one can cut the loops short in many cases but i wanted to try some maps
    for report in input.iter() {
        let safe: i32 = report
            .windows(2)
            .map(|window| {
                let delta = window[1] - window[0];
                if delta == 0 {
                    0
                } else {
                    if delta <= 3 && delta >= 0 {
                        1
                    } else if delta >= -3 && delta <= 0 {
                        -1
                    } else {
                        0
                    }
                }
            })
            .sum();

        let safe: i32 = if safe.abs() as usize >= report.len() - 1 {
            1
        } else {
            0
        };
        safe_vec.push(safe);
    }
    println!("Number of safe records {}", safe_vec.iter().sum::<i32>());
    //Part 1
    Ok(())
}
