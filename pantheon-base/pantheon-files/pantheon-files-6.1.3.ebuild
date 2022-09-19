# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2 meson vala systemd

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="https://github.com/elementary/files"
SRC_URI="https://github.com/elementary/files/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="zeitgeist systemd"

DEPEND="
	$(vala_depend)
	>=dev-util/meson-0.50.0
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-db/sqlite:3
	>=dev-libs/glib-2.40.0:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	>=x11-libs/gtk+-3.22:3[X,wayland]
	gui-libs/libhandy
	zeitgeist? ( >=gnome-extra/zeitgeist-1.0.2 )
	>=x11-misc/plank-0.10.9
	dev-libs/libcloudproviders[vala]
	dev-libs/libgit2-glib[vala]
	>=media-libs/libcanberra-0.30
	>=x11-libs/libnotify-0.7.2
	>=x11-libs/pango-1.48.5-r1
	systemd? ( sys-apps/systemd )
"

S="${WORKDIR}/files-${PV}"

src_prepare() {
	eapply_user
	sed -i 's/flatpak-builder/true/' filechooser-portal/meson.build
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dwith-zeitgeist=$(usex zeitgeist enabled disabled)
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
	)
	meson_src_configure
}

