document.addEventListener("turbo:load", function () {
    const searchInput = document.getElementById("searchUser");
  const userDropdown = document.getElementById("userDropdown");
  
  // Modifikasi ini agar mengambil elemen dengan class tertentu di dalam dropdown
  const userItems = userDropdown.querySelectorAll(".dropdown-item"); 

  searchInput.addEventListener("input", function () {
    const searchTerm = searchInput.value.toLowerCase().trim();
    let hasMatch = false;  // Inisialisasi flag untuk memeriksa apakah ada hasil yang cocok

    userItems.forEach(function (item) {
      const username = item.getAttribute("data-username").toLowerCase();
      const email = item.getAttribute("data-email").toLowerCase();

      // Cocokkan username atau email dengan input
      if (username.includes(searchTerm) || email.includes(searchTerm)) {
        item.style.display = "flex";  // Tampilkan item yang cocok
        hasMatch = true;  // Set flag jika ada kecocokan
      } else {
        item.style.display = "none";  // Sembunyikan item yang tidak cocok
      }
      
      console.log(item);
    });

    // Tampilkan dropdown jika ada hasil yang cocok, sembunyikan jika tidak ada
    if (hasMatch) {
      userDropdown.style.display = "block";
      userDropdown.classList.add("show");  // Paksa tampilkan dropdown
    } else {
      userDropdown.style.display = "none";
      userDropdown.classList.remove("show");  // Sembunyikan dropdown jika tidak ada hasil
    }
  });
});
  