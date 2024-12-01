use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn main() -> io::Result<()> {
    let input_file = "input.txt";

    let mut n1 = Vec::new();
    let mut n2 = Vec::new();

    let file = File::open(&input_file)?;

    let reader = io::BufReader::new(file);

    for line in reader.lines() {
        let line = line?;

        let numbers: Vec<i32> = line
            .split_whitespace()
            .map(|num| num.parse::<i32>().unwrap())
            .collect();

        if numbers.len() == 2 {
            n1.push(numbers[0]);
            n2.push(numbers[1]);
        }
    }

    n1.sort();
    n2.sort();

    let mut delta = 0;

    for (a, b) in n1.iter().zip(n2.iter()) {
        delta += (a - b).abs();
    }
    //Part 1 complete
    println!("Sum is {}", delta);

    let mut sim_score = 0;

    for a in n1.iter() {
        let mut times = 0;
        for b in n2.iter() {
            if a == b {
                times += 1;
            }
        }
        sim_score += times * a;
    }

    println!("Simscore is {}", sim_score);
    //Part 2 complete
    Ok(())
}
