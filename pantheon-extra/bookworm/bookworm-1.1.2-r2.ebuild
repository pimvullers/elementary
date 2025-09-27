# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="A simple ebook reader for Elementary OS "
HOMEPAGE="https://babluboy.github.io/bookworm/"
SRC_URI="https://github.com/babluboy/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="comics"
DEPEND="
	app-text/poppler[utils]
	x11-libs/gtk+:3
	dev-libs/libgee:0.8
	<dev-libs/granite-7:0
	dev-db/sqlite:3
	dev-libs/libxml2
	net-libs/webkit-gtk:4.1
	dev-libs/appstream
"
RDEPEND="${DEPEND}
	app-arch/unzip
	dev-python/html2text
	dev-lang/python:2.7
	comics? ( app-arch/unar )"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/webkit-4.1.patch"
	vala_setup
}
