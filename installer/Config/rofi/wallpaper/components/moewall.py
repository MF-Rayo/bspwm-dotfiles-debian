#!/bin/python
import os, sys, json, shutil, cloudscraper
from bs4 import BeautifulSoup
from concurrent.futures import ThreadPoolExecutor

scraper = cloudscraper.create_scraper()

def search(query, page):
    if page == 1:
        url = f"https://moewalls.com/?s={query}"
    else:
        url = f"https://moewalls.com/page/{page}/?s={query}"
    response = scraper.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    return soup

def get_data(soup):
    resultados = []
    for article in soup.select('article.entry-tpl-grid'):
        title_tag = article.select_one('h3.entry-title a')
        title = title_tag.get_text(strip=True)
        page_link = title_tag['href']
        img_tag = article.select_one('.entry-featured-media img')
        thumbnail = img_tag['src']

        resultados.append({
            "title": title,
            "page_link": page_link,
            "thumbnail": thumbnail,
        })
    return resultados

def assign_filenames(data):
    seen = {}
    for item in data:
        base = item["title"]
        if base in seen:
            seen[base] += 1
            item["filename"] = f"{base}-{seen[base]}"
        else:
            seen[base] = 0
            item["filename"] = base
    return data

def download_raw(item, raw_dir):
    ext = os.path.splitext(item["thumbnail"])[1]
    filename = f"{item['filename']}{ext}"
    dest = os.path.join(raw_dir, filename)
    
    if not os.path.exists(dest):
        response = scraper.get(item["thumbnail"])
        if response.status_code == 200: 
            with open(dest, "wb") as f:
                f.write(response.content)
    return dest

def download_all_raw(data, raw_dir):
    with ThreadPoolExecutor(max_workers=os.cpu_count()) as executor:
        executor.map(lambda item: download_raw(item, raw_dir), data)

def download_wallpaper(name, json_path, download_dir, copy_file): 
    with open(f"{json_path}/map.json", "r", encoding="utf-8") as f:
        data = json.load(f)

    target_item = None
    for item in data:
        if item.get("filename") == name:
            target_item = item
            break
    
    page_link = target_item.get("page_link")
    response = scraper.get(page_link)
    soup = BeautifulSoup(response.text, 'html.parser')
    download_tag = soup.select_one('#moe-download')
    video_param = download_tag['data-url']
    
    download_url = f"https://go.moewalls.com/download.php?video={video_param}"
    wallpaer_name = item['filename'] + ".mp4"
    filepath = os.path.join(download_dir, wallpaer_name)
    try:
        response = scraper.get(download_url, headers={"Referer": item['page_link']})
        if response.status_code == 200:
            with open(filepath, "wb") as f:
                f.write(response.content)
            shutil.copy(filepath, copy_file)
            os.system(f"notify-send -t 2000 '󱧫 Downloaded wallpaper' --icon=image;")
    except Exception:
        os.system("notify-send -t 2000 '󱧫 Error downloading wallpaper' --icon=image;")

def main():
    if sys.argv[1] == "--search":
        query = sys.argv[2]
        base_cache = sys.argv[3]
        page = sys.argv[4]

        soup = search(query, int(page))
        data = get_data(soup)
        if not data:
            os.system(f"notify-send -t 1500 'MoeWalls: No results found for wallpapers of {query}'")
            sys.exit(0)
        
        data = assign_filenames(data)
        
        with open(os.path.join(base_cache, "map.json"), "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

        download_all_raw(data, f"{base_cache}/raw")
    
    if sys.argv[1] == "--download":
        name = sys.argv[2]
        base_cache = sys.argv[3]
        download_dir = sys.argv[4]
        copy = sys.argv[5]

        if not name:
            sys.exit(0)

        download_wallpaper(name, base_cache, download_dir, copy)

if __name__ == "__main__":
    main()