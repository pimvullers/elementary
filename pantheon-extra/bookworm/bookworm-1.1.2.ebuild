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

DEPEND="
	app-arch/unzip
	app-arch/unar
	app-text/poppler[utils]
	dev-python/html2text
	dev-lang/python:2.7
	x11-libs/gtk+:3
	dev-libs/libgee:0.8
	dev-libs/granite:0
	dev-db/sqlite:3
	dev-libs/libxml2
	net-libs/webkit-gtk:4
	dev-libs/appstream
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user
	vala_setup
}

