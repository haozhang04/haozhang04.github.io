---
title: ROBOCON2023
date: 2023-07-15 12:00:00 +0800
categories: [Competition, Robocon]
tags: [ROBOCON]
---

<style>
  .hero-container {
    text-align: center;
    padding: 2.5rem;
    background-color: #f8f9fa;
    border: 1px solid #e9ecef;
    border-radius: 12px;
    margin-bottom: 2rem;
  }
  [data-mode='dark'] .hero-container {
    background-color: #2a2a2a;
    border-color: #3b3b3b;
  }
  .hero-title {
    font-size: 3.5rem;
    font-weight: 800;
    margin-bottom: 1.5rem;
    background: linear-gradient(135deg, #D32F2F 0%, #B71C1C 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    letter-spacing: -1px;
    text-shadow: 0 2px 4px rgba(211, 47, 47, 0.1);
  }
  .hero-badges {
    display: flex;
    justify-content: center;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 1.8rem;
  }
  .badge-item {
    background: linear-gradient(135deg, #FF5252 0%, #D32F2F 100%);
    color: white;
    padding: 0.5rem 1.2rem;
    border-radius: 24px;
    font-size: 1.1rem;
    font-weight: 500;
    box-shadow: 0 4px 6px rgba(211, 47, 47, 0.2);
    transition: transform 0.2s ease;
  }
  .badge-item:hover {
    transform: translateY(-2px);
  }
  .gallery-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
    margin: 2rem 0;
  }
  /* Mobile responsive adaptation */
  @media (max-width: 768px) {
    .gallery-grid {
      grid-template-columns: 1fr;
    }
    .gallery-item.full-width {
      grid-column: auto;
    }
    .gallery-item.row-span-2 {
      grid-row: auto;
    }
  }
  .gallery-item {
    position: relative;
    overflow: hidden;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  .gallery-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
  }
  .gallery-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
    transition: transform 0.5s ease;
  }
  .gallery-item:hover img {
    transform: scale(1.05);
  }
  .gallery-item.full-width {
    grid-column: span 2;
  }
  .gallery-item.row-span-2 {
    grid-row: span 2;
  }
  .video-container {
    margin-top: 3rem;
    padding: 1.5rem;
    background: #f8f9fa;
    border-radius: 16px;
    box-shadow: inset 0 2px 6px rgba(0,0,0,0.05);
  }
  /* Dark mode adaptation */
  [data-mode='dark'] .video-container {
    background: #2a2a2a;
  }
  .section-title {
    text-align: center;
    font-size: 2rem;
    font-weight: 700;
    margin: 3rem 0 2rem;
    color: var(--heading-color);
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
  }
  .section-title::before,
  .section-title::after {
    content: '';
    display: block;
    width: 40px;
    height: 4px;
    background: linear-gradient(135deg, #FF5252 0%, #D32F2F 100%);
    border-radius: 2px;
  }
</style>

<div class="hero-container">
  <div class="hero-title">ROBOCON2023</div>
  <div class="hero-badges">
    <span class="badge-item">全国一等奖</span>
    <span class="badge-item">机械组负责人</span>
  </div>
  <p style="color: var(--text-muted-color); max-width: 600px; margin: 0 auto; font-size: 1.1rem;">
    初次接触机器人。
  </p>
</div>

<h3 class="section-title">精彩瞬间</h3>

<div class="gallery-grid">
    <div class="gallery-item full-width">
        <img src="/assets/img/competition/robocon2023/mmexport1702955423983.jpg" alt="瞬间1">
    </div>
    <div class="gallery-item">
        <img src="/assets/img/competition/robocon2023/mmexport1690994394116.jpg" alt="瞬间2">
    </div>
    <div class="gallery-item">
        <img src="/assets/img/competition/robocon2023/mmexport1688963726642.jpg" alt="瞬间3">
    </div>
</div>

<center><small style="color: var(--text-muted-color); opacity: 0.8;"><i>（点击图片可查看高清大图）</i></small></center>

<h3 class="section-title">相关视频</h3>
{% include embed/bilibili.html id='BV1LW4y1f71p' %}
