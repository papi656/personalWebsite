// Theme toggle functionality
document.addEventListener('DOMContentLoaded', () => {
    const themeToggle = document.querySelector('.theme-toggle');
    const moonIcon = document.querySelector('.moon-icon');
    const sunIcon = document.querySelector('.sun-icon');
    
    // Check for saved theme preference or use system preference
    const savedTheme = localStorage.getItem('theme');
    const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    // Set initial theme - default to light mode
    if (savedTheme === 'dark') {
        document.body.classList.add('dark-mode');
        moonIcon.style.display = 'none';
        sunIcon.style.display = 'block';
    } else {
        // Default to light mode, ignore system preference
        document.body.classList.remove('dark-mode');
        moonIcon.style.display = 'block';
        sunIcon.style.display = 'none';
    }
    
    // Toggle theme on button click
    themeToggle.addEventListener('click', () => {
        const isDarkMode = document.body.classList.toggle('dark-mode');
        
        if (isDarkMode) {
            moonIcon.style.display = 'none';
            sunIcon.style.display = 'block';
            localStorage.setItem('theme', 'dark');
        } else {
            moonIcon.style.display = 'block';
            sunIcon.style.display = 'none';
            localStorage.setItem('theme', 'light');
        }
    });
    
    // Listen for system theme changes - but default to light mode
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
        // Only follow system preference if no user preference is set
        // But since we default to light mode, this is mostly for future reference
        if (!localStorage.getItem('theme')) {
            // Default behavior is light mode, so we'll keep it that way
            document.body.classList.remove('dark-mode');
            moonIcon.style.display = 'block';
            sunIcon.style.display = 'none';
        }
    });
});
