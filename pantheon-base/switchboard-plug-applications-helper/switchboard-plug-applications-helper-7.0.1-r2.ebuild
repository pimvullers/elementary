# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit gnome2 meson vala

DESCRIPTION="Application configuration management"
HOMEPAGE="https://github.com/elementary/switchboard-plug-applications"
SRC_URI="https://github.com/elementary/switchboard-plug-applications/archive/${PV}.tar.gz -> switchboard-plug-applications-${PV}.tar.gz"

S="${WORKDIR}/switchboard-plug-applications-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	!pantheon-base/switchboard-plug-applications:0
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/switchboard:2
	x11-libs/gtk+:3
	sys-apps/flatpak
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}

src_install() {
	meson_src_install
	rm -r "${ED}/usr/lib64"
	rm -r "${ED}/usr/share/{doc,locale,metainfo}"
}
