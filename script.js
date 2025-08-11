document.addEventListener('DOMContentLoaded', () => {
    const countdownCard = document.querySelector('.countdown-card');
    if (countdownCard) {
        const targetDateStr = countdownCard.dataset.targetDate;
        const targetDate = new Date(targetDateStr).getTime();

        const updateCountdown = () => {
            const now = new Date().getTime();
            const distance = targetDate - now;

            const days = Math.floor(distance / (1000 * 60 * 60 * 24));
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);

            document.querySelector('.countdown-display .days').textContent = String(days).padStart(2, '0');
            document.querySelector('.countdown-display .hours').textContent = String(hours).padStart(2, '0');
            document.querySelector('.countdown-display .minutes').textContent = String(minutes).padStart(2, '0');
            document.querySelector('.countdown-display .seconds').textContent = String(seconds).padStart(2, '0');

            if (distance < 0) {
                clearInterval(countdownInterval);
                document.querySelector('.countdown-display').textContent = "EXPIRED";
            }
        };

        updateCountdown(); // Initial call to display immediately
        const countdownInterval = setInterval(updateCountdown, 1000);
    }
});
