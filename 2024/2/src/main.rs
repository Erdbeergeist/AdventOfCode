use std::arch::aarch64::vabal_s8;
use std::fs::File;
use std::io::{self, BufRead};
use std::process::id;

fn check_report(report: &Vec<i32>) -> i32 {
    let safe: Vec<i32> = report
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
        .collect();
    let safe_val: i32 = if safe.iter().sum::<i32>().abs() as usize >= (report.len() - 1) {
        1
    } else {
        0
    };
    return safe_val;
}

fn is_safe(input: &Vec<Vec<i32>>, remove_level: bool) -> Vec<i32> {
    let mut safe_vec: Vec<i32> = Vec::new();
    for report in input.iter() {
        let mut safe_val = check_report(report);
        if remove_level == true && safe_val == 0 {
            for i in 0..report.len() {
                let filtered_report = report
                    .iter()
                    .enumerate()
                    .filter(|&(j, _)| j != i)
                    .map(|(_, &val)| val)
                    .collect();
                safe_val = check_report(&filtered_report);
                if safe_val == 1 {
                    break;
                }
            }
        }
        safe_vec.push(safe_val);
    }
    return safe_vec;
}

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

    // I understand that one can cut the loops short in many cases but i wanted to try some maps
    println!(
        "Number of safe records {}",
        is_safe(&input, false).iter().sum::<i32>()
    );
    //Part 2
    println!(
        "Number of safe records {}",
        is_safe(&input, true).iter().sum::<i32>()
    );
    Ok(())
}
